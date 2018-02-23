/************************************************************************/
/*																		*/
/* pmodhb3.h	--	Interface Declarations for pmodhb3.c				*/
/*																		*/
/************************************************************************/
/*	Author:		Wray Price												*/
/************************************************************************/

#ifndef PMODHB3_H
#define PMODHB3_H


int InitAXITimer(void);

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

#endif //PMODHB3_H