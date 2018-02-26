/************************************************************************/
/*																		*/
/* pmodhb3.h	--	Interface Declarations for pmodhb3.c				*/
/*																		*/
/************************************************************************/
/*	Author:		Wray Price												*/
/************************************************************************/

#ifndef PMODHB3_H
#define PMODHB3_H
#include <stdint.h>
#include <stdbool.h>

int InitPmodHB3(void);

/* ------------------------------------------------------------ */
/***	void SetPWM(float dutyCycle)
**
**	Parameters:
**		dutyCycle: value from 0-1 representing the duty cycle
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		Sets the duty cycle of the AXI Timer
*/
void SetPWM(float dutyCycle);

/* ------------------------------------------------------------ */
/***	float GetRPM(void)
**
**	Parameters:
**		none
**	Return Value:
**		Computed RPM value
**
**	Errors:
**		none
**
**	Description:
**		Reads the computed RPM value based on the frequency of 
** 		Hall Sensor updates
*/
float GetRPM(void);

/* ------------------------------------------------------------ */
/***	void SetDirection(bool Direction)
**
**	Parameters:
**		Direction: determines which direction the motor is to rotate
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		sets the direction of the motor
*/
void SetDirection(bool Direction);

/* ------------------------------------------------------------ */
/***	void Hall_Handler(void)
**
**	Parameters:
**		none
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		GPIO interrupt function that is called when the hall sensor is detected.
** 		This function will compute the RPM from the interrupt call frequency.
*/
void Hall_Handler(void);	

#endif //PMODHB3_H
