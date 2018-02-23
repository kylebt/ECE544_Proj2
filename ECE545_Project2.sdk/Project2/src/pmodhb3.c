/************************************************************************/
/*																		*/
/* pmodhb3.c	--	driver for  pmodhb3 module							*/
/*																		*/
/************************************************************************/
/*	Author:		Wray Price												*/
/************************************************************************/
/*  Module Description: 												*/
/*																		*/
/************************************************************************/
/*  Revision History:													*/
/*																		*/
/*	02/21/2018(Wray Price): created										*/
/*																		*/
/************************************************************************/

/***************************** Include Files *******************************/
#include "pmodhb3.h"
#include "xtmrctr.h"
#include "xparameters.h"


/****************************** Constants **********************************/
#define AXI_TIMER_BASEADDR XPAR_AXI_TIMER_1_BASEADDR
#define PWM_PERIOD_COUNT	24998	//4KHz operation

/*************************** Private Functions *****************************/

/* ------------------------------------------------------------ */
/***	int InitAXITimer(void)
**
**	Parameters:
**		none
**	Return Value:
**		int: Error
**
**	Errors:
**		
**
**	Description:
**		Initialize the AXI timer for PWM operation to drive HB3 EN signal
*/
int InitAXITimer(void)
{
	u32		ctlsts;		// control/status register or mask
	//configure AXI timer for PWM operation

	//The mode for both Timer 0 and Timer 1 must be set to Generate mode (bit MDT in the TCSR set to 0).
	
	//The PWMA0 bit in TCSR0 and PWMB0 bit in TCSR1 must be set to 1 to enable PWM mode.

	//The GenerateOut signals must be enabled in the TCSR (bit GENT set to 1). The PWM0
	//signal is generated from the GenerateOut signals of Timer 0 and Timer 1, so these
	//signals must be enabled in both timer/counters.
	XTmrCtr_SetControlStatusReg(AXI_TIMER_BASEADDR,0,XTC_CSR_ENABLE_PWM_MASK | XTC_CSR_DOWN_COUNT_MASK | XTC_CSR_EXT_GENERATE_MASK);		//set PWMA0 and GENT0
	XTmrCtr_SetControlStatusReg(AXI_TIMER_BASEADDR,1,XTC_CSR_ENABLE_PWM_MASK | XTC_CSR_DOWN_COUNT_MASK | XTC_CSR_EXT_GENERATE_MASK);		//set PWMA1 and GENT1

	//set PWM period for 4KHz
	XTmrCtr_SetLoadReg(AXI_TIMER_BASEADDR, 0, PWM_PERIOD_COUNT);

	ctlsts = XTmrCtr_GetControlStatusReg(AXI_TIMER_BASEADDR, 0);
	ctlsts &= (~XTC_CSR_LOAD_MASK);
	XTmrCtr_SetControlStatusReg(AXI_TIMER_BASEADDR, 0, ctlsts);


	//set initial duty cycle to 0
	XTmrCtr_SetLoadReg(AXI_TIMER_BASEADDR, 1,0);

	ctlsts = XTmrCtr_GetControlStatusReg(AXI_TIMER_BASEADDR, 1);
	ctlsts &= (~XTC_CSR_LOAD_MASK);
	XTmrCtr_SetControlStatusReg(AXI_TIMER_BASEADDR, 1, ctlsts);

	//enable timer0
	XTmrCtr_Enable(AXI_TIMER_BASEADDR,0);

	//enable timer1
	XTmrCtr_Enable(AXI_TIMER_BASEADDR,1);

	return 0;
}


/*************************** Public Functions ******************************/
void SetPWM(float dutyCycle)
{
	u32		ctlsts;		// control/status register or mask

	//perform bounds check on duty cycle
	if(dutyCycle < 0)
	{
		dutyCycle = 0;
	}
	if(dutyCycle > 1)
	{
		dutyCycle = 1;
	}

	//set timer 1 period to new duty cycle
	XTmrCtr_SetLoadReg(AXI_TIMER_BASEADDR, 1,(PWM_PERIOD_COUNT-1)*dutyCycle);

	//ctlsts = XTmrCtr_GetControlStatusReg(AXI_TIMER_BASEADDR, 1);
	//ctlsts &= (~XTC_CSR_LOAD_MASK);
	//XTmrCtr_SetControlStatusReg(AXI_TIMER_BASEADDR, 1, ctlsts);
}
