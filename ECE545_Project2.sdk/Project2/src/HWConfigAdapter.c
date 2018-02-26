/*
 * HWConfigAdapter.cpp
 *
 *  Created on: Feb 21, 2018
 *      Author: Kyle
 *
 *  Description: Functions that implement hardware specific functionality.
 *  The intent is that any changes in hardware or embedded system only
 *  cause changes in this file, and this file could differ if two
 *  people's hardware sets have different performance.
 */

#include "HWConfigAdapter.h"
#include "pmodhb3.h"
#include "xparameters.h"
#include "pmodENC.h"
#include "xgpio.h"
#include "xintc.h"
#include "watchdog.h"
#include "math.h"

// Definitions for peripheral PMODOLEDRGB
#define RGBDSPLY_DEVICE_ID		XPAR_PMODOLEDRGB_0_DEVICE_ID
#define RGBDSPLY_GPIO_BASEADDR	XPAR_PMODOLEDRGB_0_AXI_LITE_GPIO_BASEADDR
#define RGBDSPLY_GPIO_HIGHADDR	XPAR_PMODOLEDRGB_0_AXI_LITE_GPIO_HIGHADD
#define RGBDSPLY_SPI_BASEADDR	XPAR_PMODOLEDRGB_0_AXI_LITE_SPI_BASEADDR
#define RGBDSPLY_SPI_HIGHADDR	XPAR_PMODOLEDRGB_0_AXI_LITE_SPI_HIGHADDR

// Definitions for peripheral PMODENC
#define PMODENC_DEVICE_ID		XPAR_PMODENC_0_DEVICE_ID
#define PMODENC_BASEADDR		XPAR_PMODENC_0_S00_AXI_BASEADDR
#define PMODENC_HIGHADDR		XPAR_PMODENC_0_S00_AXI_HIGHADDR

//GPIO
#define GPIO_0_DEVICE_ID			XPAR_AXI_GPIO_0_DEVICE_ID
#define GPIO_0_INPUT_0_CHANNEL		2	//Slide Switches
#define GPIO_0_OUTPUT_0_CHANNEL		1	//LEDs

#define GPIO_1_DEVICE_ID			XPAR_AXI_GPIO_1_DEVICE_ID
#define GPIO_1_INPUT_0_CHANNEL		1

#define GPIO_2_DEVICE_ID			XPAR_AXI_GPIO_2_DEVICE_ID
#define GPIO_2_INPUT_0_CHANNEL		1	//Slide Switches
#define GPIO_2_OUTPUT_0_CHANNEL		2	//LEDs

// Interrupt Controller parameters
#define INTC_DEVICE_ID			XPAR_INTC_0_DEVICE_ID

//Application constants
#define ROTARY_INC		1		//increment / decrement value per rotary click
#define ROTARY_NO_NEG	false	//disallow negative enocoder values.

//Application Variables
static PmodOLEDrgb	pmodOLEDrgb_inst;
static PmodENC 	pmodENC_inst;
static XGpio		GPIOInst0;
static XGpio 		GPIOInst1;
XIntc 		IntrptCtlrInst;				// Interrupt Controller instance

int InitHardware(void)
{
	uint32_t status;				// status from Xilinx Lib calls

	OLEDrgb_begin(&pmodOLEDrgb_inst, RGBDSPLY_GPIO_BASEADDR, RGBDSPLY_SPI_BASEADDR);

	// initialize the pmodENC and hardware
	status = pmodENC_initialize(&pmodENC_inst, PMODENC_BASEADDR);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	//initialize rotary encoder
	pmodENC_init(&pmodENC_inst, ROTARY_INC, ROTARY_NO_NEG);
	pmodENC_clear_count(&pmodENC_inst);


	// initialize the GPIO instances
	status = XGpio_Initialize(&GPIOInst0, GPIO_0_DEVICE_ID);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	// initialize the GPIO instances
	status = XGpio_Initialize(&GPIOInst1, GPIO_1_DEVICE_ID);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}


	//Switches are the input port, LEDs are output port
	// GPIO0 channel 1 is a 16-bit input port.
	// GPIO0 channel 2 is an 16-bit output port.
	XGpio_SetDataDirection(&GPIOInst0, GPIO_0_INPUT_0_CHANNEL, 0xFFFF);
	XGpio_SetDataDirection(&GPIOInst0, GPIO_0_OUTPUT_0_CHANNEL, 0x0000);

	//Pushbuttons GPIO
	// GPIO1 channel 1 is an 5-bit input port.
	XGpio_SetDataDirection(&GPIOInst0, GPIO_0_INPUT_0_CHANNEL, 0x001F);

	// initialize the interrupt controller
	status = XIntc_Initialize(&IntrptCtlrInst, INTC_DEVICE_ID);
	if (status != XST_SUCCESS)
	{
	   return XST_FAILURE;
	}

	//initialize watchdog timer
	status = InitWatchDog();
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	// start the interrupt controller such that interrupts are enabled for
	// all devices that cause interrupts.
	status = XIntc_Start(&IntrptCtlrInst, XIN_REAL_MODE);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	//start watchdog timer
	StartWatchDog();

	return 0;
}

uint16_t GetSwitches()
{
	return (uint16_t) XGpio_DiscreteRead(&GPIOInst0, GPIO_0_INPUT_0_CHANNEL);
}

void SetLEDs(uint16_t ledState)
{
	XGpio_DiscreteWrite(&GPIOInst0, GPIO_0_OUTPUT_0_CHANNEL, ledState);
}

BUTTON_STATE GetPushButtons()
{
	BUTTON_STATE buttonState;
	uint32_t buttons = XGpio_DiscreteRead(&GPIOInst1, GPIO_1_INPUT_0_CHANNEL);
	buttonState.downButton = (buttons >> 4) & 0x1;
	buttonState.rightButton = (buttons >> 3) & 0x1;
	buttonState.leftButton = (buttons >> 2) & 0x1;
	buttonState.upButton = (buttons >> 1) & 0x1;
	buttonState.centerButton = (buttons) & 0x1;
	return buttonState;
}

int16_t GetRotaryCount(bool clearCountAfter)
{
	uint16_t rotaryCount;
	pmodENC_read_count(&pmodENC_inst, &rotaryCount);
	if(clearCountAfter)
		pmodENC_clear_count(&pmodENC_inst);

	//To get counter clockwise rotation to be a positive increment, need to invert count
	return (int16_t) -rotaryCount;
}

PmodOLEDrgb* GetOLEDDisplayHandle()
{
	return &pmodOLEDrgb_inst;
}

//#define AVERAGE_RPM_READING
RPM_TYPE GetMotorRpm()
{
#ifdef AVERAGE_RPM_READING
	//Averaging out measurements because sometimes RPM returns falsely as 0
	//TODO: Simplify this once the 0 RPM bug is fixed.
	const int SamplesToAverage = 5;
	static int sampleIndex = 0;
	static bool initialized = FALSE;
	static float measurements[5];
	float newMeasurement = GetRPM();
	sampleIndex = sampleIndex % SamplesToAverage;
	if(!initialized)
	{
		if(sampleIndex == SamplesToAverage - 1) initialized = TRUE;
		measurements[sampleIndex++] = newMeasurement;
		return newMeasurement;
	}
	else if(initialized)
	{
		float average = 0.0;
		for(int i = 0; i < SamplesToAverage; ++i)
		{
			average += measurements[i];
		}
		measurements[sampleIndex++] = newMeasurement;
		return average / SamplesToAverage;

		//if(fabsf(newMeasurement - average) < 2000)
		//{
		//	measurements[sampleIndex++] = newMeasurement;
		//}

		//return average;
	}
	return newMeasurement;
#else
	return GetRPM();
#endif
}

void SetMotorRpm(RPM_TYPE rpm)
{
	//float pwm = ConvertRpmToPwm(rpm);
	float pwm = (float)rpm/10000;
	SetPWM(pwm);
}

float ConvertRpmToPwm(RPM_TYPE rpm)
{
	float pwm = 0.0;

	//Formulae obtained via experimentation with Kyle's unloaded motor
	if(rpm <= 0)
	{
		pwm = 0.0;
	}
	else if(rpm <= 6750)
	{
		pwm = (((float) rpm) * 0.004 + 18.83) / 100;
	}
	else if(rpm <= 11500)
	{
		pwm = (((float) rpm) * 0.0075 - 5.154) / 100;
	}
	else
	{
		pwm = 82.0; //Max for protection
	}
	return pwm;
}
