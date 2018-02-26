/*
 * Project2Helpers.c
 *
 *  Created on: Feb 21, 2018
 *      Author: Kyle
 */
#include "Project2Helpers.h"
#include "FreeRTOSConfig.h"
#include "string.h"
#include <stdio.h>

//TODO: Determine reasonable numbers for these
PID_K_SELECT DefaultKp = 10;
PID_K_SELECT DefaultKi = 10;
PID_K_SELECT DefaultKd = 10;

//****************************************************************
// HELPER FUNCTIONS FOR MODIFY STATE
//****************************************************************
uint8_t GetPidConstantIncrement(uint16_t switches)
{
	//Per project requirements:
	//	Switch[5] being set increments count by 10
	//	Switch[4] being set without Switch[5] increments count by 5
	// 	Neither 4 nor 5 being set increments count by 1
	if(switches & 1 << 5) return 10;
	else if(switches & 1 << 4) return 5;
	else return 1;
}

uint8_t GetRpmIncrement(uint16_t switches)
{
	//Per project requirements:
	//	Switch[1] being set increments count by 10
	//	Switch[0] being set without Switch[5] increments count by 5
	// 	Neither 0 nor 1 being set increments count by 1
	if(switches & 1 << 1) return 10;
	else if(switches & 1 << 0) return 5;
	else return 1;
}

PID_K_SELECT GetPidConstantSelect(uint16_t switches)
{
	//Requirements were slightly ambiguous, so here's how we're defining this:
	//	If switch[3] is set, select KP
	// 	If only switch[2] is set, select KI
	//  If neither 2 nor 3 are set, select KD
	if(switches & 1 << 3) return KP;
	else if(switches & 1 << 2) return KI;
	else return KD;
}

/**
 * @brief Takes the user inputs and modifies a software state variable.
 *
 * @input switches The current state of the switches.
 * @input buttons The current state of the buttons.
 * @input encoderCount The current encoder count. Expected to be reset after this function call.
 * @inout params On input, this is the old software state. This structure is modified to then reflect the new software state.
 * @input forceReset Force reset the state specified by <params>.
 *
 * @note Additional protection is needed against context switching in the middle of this function, depending on scope.
 * @note Pushing the center button will result in a reset of the parameters.
 */
void ModifyState(uint16_t switches, BUTTON_STATE buttons, int16_t encoderCount, STATE_PARAMS* params, bool forceReset)
{
	params->rpmIncrement = GetRpmIncrement(switches);
	params->kIncrement = GetPidConstantIncrement(switches);
	params->select = GetPidConstantSelect(switches);

	int16_t pidConstantModifier = 0;

	if(buttons.centerButton || forceReset)
	{
		params->kp = DefaultKp;
		params->ki = DefaultKi;
		params->kd = DefaultKd;
		params->expectedRpm = 0;
		return;
	}
	else if(buttons.upButton && !buttons.downButton)
		pidConstantModifier = params->kIncrement;
	else if(buttons.downButton && !buttons.upButton)
		pidConstantModifier = -params->kIncrement;

	switch(params->select)
	{
	case KP:
		params->kp = params->kp + pidConstantModifier;
		//TODO: Add limits for what this can be set to
		break;
	case KI:
		params->ki = params->ki + pidConstantModifier;
		//TODO: Add limits for what this can be set to
		break;
	case KD:
		params->kd = params->kd + pidConstantModifier;
		//TODO: Add limits for what this can be set to
		break;
	default:
		configASSERT("Should never get here!");
	}

	params->expectedRpm = params->expectedRpm + params->rpmIncrement * encoderCount;
	if(params->expectedRpm < 0) params->expectedRpm = 0;
	//TODO: Put upper bounds on RPM based on characterization
}


//****************************************************************
// HELPER FUNCTIONS FOR OLED SET DISPLAY
//****************************************************************
STATE_PARAMS OldState;
bool IsDisplayInitialized = FALSE;
uint16_t WHITE;
uint16_t YELLOW;

const uint32_t DISPLAY_CHAR_WIDTH = 12;

const int RpmHeaderRow = 0;
const char* RpmHeader = "MOTOR SPEED";

const int ExpectedRpmRow = 1;
const char* ExpectedRpmHeader = "SET: %7d";

const int ActualRpmRow = 2;
const char* ActualRpmHeader = "ACT: %7d";

const int PidValueRow = 4;
const char* PidValueHeader = "PID VALUES";

const int KpRow = 5;
const char* KpHeader = "Kp: %8d";

const int KiRow = 6;
const char* KiHeader = "Ki: %8d";

const int KdRow = 7;
const char* KdHeader = "Kd: %8d";

void InitializeDisplay(PmodOLEDrgb* oled)
{
	WHITE = OLEDrgb_BuildRGB(0xFF, 0xFF, 0xFF);
	YELLOW = OLEDrgb_BuildRGB(0xFF, 0xFF, 0x00); //Initialize for later use

	//Only write lines which will not change

	OLEDrgb_Clear(oled);
	OLEDrgb_SetFontColor(oled, WHITE);

	OLEDrgb_SetCursor(oled, 0, RpmHeaderRow);
	OLEDrgb_PutString(oled, (char*) RpmHeader);

	OLEDrgb_SetCursor(oled, 0, PidValueRow);
	OLEDrgb_PutString(oled, (char*) PidValueHeader);
}

/**
 * @brief A function to display output to the user via the OLED RGB display.
 */
//This function sets the OLED RGB Display with HSV data and color box
//Layout:
//_____________
//|MOTOR SPEED|
//|SET: YYY	  |
//|ACT: ZZZ   |
//|           |
//|PID VALUES |
//|Kp: PPP    |
//|Ki: III    |
//|Kd: DDD    |
//|===========|
//
//For the current PID value that is being changed, it will be highlighted yellow
void OLEDSetDisplay(PmodOLEDrgb* oled, STATE_PARAMS* newState)
{
	bool forceWriteAll = FALSE;
	if(!IsDisplayInitialized)
	{
		InitializeDisplay(oled);
		IsDisplayInitialized = TRUE;
		forceWriteAll = TRUE;
	}

	char temp[DISPLAY_CHAR_WIDTH + 1]; //For converting numeric values to strings

	OLEDrgb_SetFontColor(oled, WHITE);

	//Write RPM values to display
	if(OldState.expectedRpm != newState->expectedRpm || forceWriteAll)
	{
		OLEDrgb_SetCursor(oled, 0, ExpectedRpmRow);
		sprintf(temp, ExpectedRpmHeader, newState->expectedRpm);
		OLEDrgb_PutString(oled, temp);
	}
	if(OldState.actualRpm != newState->actualRpm || forceWriteAll)
	{
		OLEDrgb_SetCursor(oled, 0, ActualRpmRow);
		sprintf(temp, ActualRpmHeader, newState->actualRpm);
		OLEDrgb_PutString(oled, temp);
	}

	//Write PID Constants to display
	uint16_t color = WHITE;
	bool selectionChanged = OldState.select != newState->select;

	bool needColorChange = selectionChanged && (OldState.select == KP || newState->select == KP);
	if(OldState.kp != newState->kp || needColorChange || forceWriteAll)
	{
		color = (newState->select == KP) ? YELLOW : WHITE;
		OLEDrgb_SetFontColor(oled, color);
		OLEDrgb_SetCursor(oled, 0, KpRow);
		sprintf(temp, KpHeader, newState->kp);
		OLEDrgb_PutString(oled, temp);
	}

	needColorChange = selectionChanged && (OldState.select == KI || newState->select == KI);
	if(OldState.ki != newState->ki || needColorChange || forceWriteAll)
	{
		color = (newState->select == KI) ? YELLOW : WHITE;
		OLEDrgb_SetFontColor(oled, color);
		OLEDrgb_SetCursor(oled, 0, KiRow);
		sprintf(temp, KiHeader, newState->ki);
		OLEDrgb_PutString(oled, temp);
	}

	needColorChange = selectionChanged && (OldState.select == KD || newState->select == KD);
	if(OldState.kd != newState->kd || needColorChange || forceWriteAll)
	{
		color = (newState->select == KD) ? YELLOW : WHITE;
		OLEDrgb_SetFontColor(oled, color);
		OLEDrgb_SetCursor(oled, 0, KdRow);
		sprintf(temp, KdHeader, newState->kd);
		OLEDrgb_PutString(oled, temp);
	}

	OldState = *newState;
}

uint16_t FormatLEDOutput(PID_K_SELECT pidConstantSelection)
{
	uint16_t leds;

	if(pidConstantSelection == KP) 		leds = 1 << 2;
	else if(pidConstantSelection == KI) leds = 1 << 1;
	else								leds = 1 << 0;

	return leds;
}

//****************************************************************
// HELPER FUNCTIONS FOR PID ALGORITHM
//****************************************************************

#define USE_PID_ALGORITHM

#define INTEGRAL_MAX 10000
#define INTEGRAL_MIN -10000

RPM_TYPE OldRpm = 0;
float IntegralState = 0.0;

/**
 * @brief Takes the actual rpm, expected rpm, and PID constants, and determines the RPM set point based on the PID algorithm.
 *
 * Used "PID Without a PhD" as a reference guide.
 */
RPM_TYPE PIDAlgorithm(STATE_PARAMS* params)
{
#ifdef USE_PID_ALGORITHM
	float error = params->expectedRpm - params->actualRpm;

	//Proportional term


	//Integral term
	IntegralState += error * (float)params->ki/1000;
	if(IntegralState > INTEGRAL_MAX) IntegralState = INTEGRAL_MAX;
	else if(IntegralState < INTEGRAL_MIN) IntegralState = INTEGRAL_MIN;

	float propTerm = error * (float)params->kp/100;
	float intTerm = IntegralState;

	//Derivative term
	float dirTerm = (params->actualRpm - OldRpm) * (float)params->kd/10;

	OldRpm = params->actualRpm;
	return propTerm + intTerm - dirTerm;// + (IntegralState * params->ki);
#else
	return params->expectedRpm;
#endif
}

