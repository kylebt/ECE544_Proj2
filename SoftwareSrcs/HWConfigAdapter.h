/*
 * HWConfigAdpater.h
 *
 *  Created on: Feb 21, 2018
 *      Author: Kyle
 */

#ifndef SRC_HWCONFIGADAPTER_H_
#define SRC_HWCONFIGADAPTER_H_

#include "PmodOLEDrgb.h"
#include <stdint.h>

#include "Project2Types.h"

int InitHardware(void);
uint16_t GetSwitches();
void SetLEDs(uint16_t ledState);
BUTTON_STATE GetPushButtons();
int16_t GetRotaryCount(bool clearCountAfterwards);
PmodOLEDrgb* GetOLEDDisplayHandle();

RPM_TYPE GetMotorRpm();
void SetMotorRpm(RPM_TYPE rpm);

#endif /* SRC_HWCONFIGADAPTER_H_ */
