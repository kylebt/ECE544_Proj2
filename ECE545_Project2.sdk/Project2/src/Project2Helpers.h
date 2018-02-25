/*
 * Project2Helpers.h
 *
 *  Created on: Feb 21, 2018
 *      Author: Kyle
 */

#ifndef SRC_PROJECT2HELPERS_H_
#define SRC_PROJECT2HELPERS_H_

#include "PmodOLEDRgb.h"
#include "Project2Types.h"

/**
 * @brief Takes the user inputs and modifies a software state variable.
 *
 * @input switches The current state of the switches.
 * @input buttons The current state of the buttons.
 * @input encoderCount The current encoder count.
 * @inout params On input, this is the old software state. This structure is modified to then reflect the new software state.
 *
 * @return A boolean representing whether or not the state needs to be reset. Pushing the center button will result in this being true.
 */
void ModifyState(uint16_t switches, BUTTON_STATE buttons, int16_t encoderCount, STATE_PARAMS* state, bool forceReset);

/**
 * @brief A function to display output to the user via the OLED RGB display.
 *
 * @input oled The handle to the PMOD OLED Display.
 * @input newState The state information to display.
 */
void OLEDSetDisplay(PmodOLEDrgb* oled, STATE_PARAMS* newState);

/**
 *
 */
uint16_t FormatLEDOutput(PID_K_SELECT pidConstantSelection);

/**
 * @brief Takes the actual rpm, expected rpm, and PID constants, and determines the RPM set point based on the PID algorithm.
 */
RPM_TYPE PIDAlgorithm(STATE_PARAMS* params);

#endif /* SRC_PROJECT2HELPERS_H_ */
