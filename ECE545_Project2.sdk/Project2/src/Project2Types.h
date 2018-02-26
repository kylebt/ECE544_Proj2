/*
 * Project2Types.h
 *
 *  Created on: Feb 21, 2018
 *      Author: Kyle
 */

#ifndef SRC_PROJECT2TYPES_H_
#define SRC_PROJECT2TYPES_H_

#include <stdbool.h>
#include <stdint.h>

typedef enum
{
	KP,
	KI,
	KD
} PID_K_SELECT;

typedef enum
{
	FORWARD,
	REVERSE
} DIRECTION;

typedef int32_t RPM_TYPE; //Important that this is a signed type, multiple sections of code depend on it!
typedef uint16_t PID_K_TYPE;

typedef struct
{
	RPM_TYPE expectedRpm;
	RPM_TYPE actualRpm;
	uint8_t rpmIncrement;
	DIRECTION direction;
	bool enabled;
	PID_K_TYPE kp;
	PID_K_TYPE ki;
	PID_K_TYPE kd;
	uint8_t kIncrement;
	PID_K_SELECT select;
	bool isShuttingDown;
} STATE_PARAMS;

typedef struct
{
	uint8_t upButton : 1;
	uint8_t downButton : 1;
	uint8_t leftButton : 1;
	uint8_t rightButton : 1;
	uint8_t centerButton : 1;
} BUTTON_STATE;

#endif /* SRC_PROJECT2TYPES_H_ */
