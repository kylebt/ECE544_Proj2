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
#include "xintc.h"
#include "xgpio.h"
#include "FreeRTOS.h"
#include <stdbool.h>
#include "task.h"
#include "timers.h"
#include "semphr.h"

/****************************** Constants **********************************/
#define AXI_TIMER_BASEADDR XPAR_AXI_TIMER_1_BASEADDR
#define PWM_PERIOD_COUNT	24998	//4KHz operation

#define GPIO_2_DEVICE_ID			XPAR_AXI_GPIO_2_DEVICE_ID
#define GPIO_2_INPUT_0_CHANNEL		1	//Hall Sensor(s)
#define GPIO_2_OUTPUT_0_CHANNEL		2	//Direction
#define HALL_INTERRUPT_ID			XPAR_MICROBLAZE_0_AXI_INTC_AXI_GPIO_2_IP2INTC_IRPT_INTR
#define HALL_SENSOR_MASK			0x01

#define HALL_SAMPLE_AVERAGE_SIZE	50	//number of samples to average for RPM computation
#define HALL_TIMEOUT				100 //time in milliseconds of no hall readings before RPM is set to 0
/************************* File Scope Variables ****************************/
static XGpio GPIOInst2;
static float RPM;
extern XIntc IntrptCtlrInst;				// Interrupt Controller instance
static TimerHandle_t TimeoutTimer;
static SemaphoreHandle_t HallActive;

/*************************** Private Functions *****************************/


/* ------------------------------------------------------------ */
/***	void HallTimeout( TimerHandle_t xTimer )
**
**	Parameters:
**		xTimer: timer handle passed in by FreeRTOS kernal
**	Return Value:
**		none
**
**	Errors:
**		none
**
**	Description:
**		resets RPM to 0 when there has been no hall sensor events for the period
**		specified by HALL_TIMEOUT
*/
void HallTimeout( TimerHandle_t xTimer )
{
	//if there was no Hall sensor activity
	if(xSemaphoreTake(HallActive,0) == pdFALSE)
	{
		//reset RPM to 0
		RPM = 0;
	}
	xTimerReset(TimeoutTimer,100);
}


/* ------------------------------------------------------------ */
/***	int InitPmodHB3(void)
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
**		Initialize the PmodHB3 for operation to drive the motor and read RPM
*/
int InitPmodHB3(void)
{
	u32		ctlsts;		// control/status register or mask
	uint32_t status;	// status from Xilinx Lib calls

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

	// initialize the GPIO instances
	status = XGpio_Initialize(&GPIOInst2, GPIO_2_DEVICE_ID);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	// GPIO2 channel 1 is an 2-bit input port.
	// GPIO2 channel 2 is an 1-bit output port.
	XGpio_SetDataDirection(&GPIOInst2, GPIO_2_INPUT_0_CHANNEL, 0x0003);
	XGpio_SetDataDirection(&GPIOInst2, GPIO_2_OUTPUT_0_CHANNEL, 0x0000);

	// connect the gpio timer (hall effect) handler to the interrupt
	status = XIntc_Connect(&IntrptCtlrInst, HALL_INTERRUPT_ID,
						   (XInterruptHandler)Hall_Handler,
						   (void *)0);
	if (status != XST_SUCCESS)
	{
		return XST_FAILURE;

	}

	//enable GPIO interrupt for hall sensor
	XGpio_InterruptEnable(&GPIOInst2, HALL_SENSOR_MASK);
	XGpio_InterruptGlobalEnable(&GPIOInst2);

	// enable the hALL interrupt
	XIntc_Enable(&IntrptCtlrInst, HALL_INTERRUPT_ID);

	//Create timeout timer
	TimeoutTimer = xTimerCreate("Timeout",HALL_TIMEOUT/portTICK_PERIOD_MS, pdTRUE,0,&HallTimeout );

	xTimerReset(TimeoutTimer,100);

	HallActive = xSemaphoreCreateBinary();

	return 0;
}


/*************************** Public Functions ******************************/
void SetPWM(float dutyCycle)
{
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

void SetDirection(bool Direction)
{
	uint32_t tempPWMVal;

	//save current PWM value
	tempPWMVal = XTmrCtr_GetLoadReg(AXI_TIMER_BASEADDR, 1);

	//set PWM module to off
	XTmrCtr_SetLoadReg(AXI_TIMER_BASEADDR, 1,0);

	//set direction
	if(Direction)
	{
		XGpio_DiscreteWrite(&GPIOInst2, GPIO_2_OUTPUT_0_CHANNEL, 0x01);
	}
	else
	{
		XGpio_DiscreteWrite(&GPIOInst2, GPIO_2_OUTPUT_0_CHANNEL, 0x00);
	}

	//restore PWM value
	XTmrCtr_SetLoadReg(AXI_TIMER_BASEADDR, 1,tempPWMVal);
}

float GetRPM(void)
{
	float RPMVal;
	//critical section to prevent interrupt from modifying value while it's read
	taskENTER_CRITICAL();
	RPMVal = RPM;
	taskEXIT_CRITICAL();
	return RPMVal;
}

void Hall_Handler(void)
{
	static TickType_t History[HALL_SAMPLE_AVERAGE_SIZE];
	static uint32_t SampleNum = 0;
	static bool FirstRun = true;
	uint32_t DeltaT;
	BaseType_t xHigherPriorityTaskWoken = pdFALSE;

	//only process if a rising edge was detected
	if(XGpio_DiscreteRead(&GPIOInst2, GPIO_2_INPUT_0_CHANNEL) && HALL_SENSOR_MASK)
	{

		//initialize History on first run
		if(FirstRun == true)
		{
			int i;
			for(i=0;i<HALL_SAMPLE_AVERAGE_SIZE;i++)
			{
				History[i] = 0;
			}
			FirstRun = false;
		}

		//save new tick value
		History[SampleNum] = xTaskGetTickCountFromISR();

		//compute time difference
		DeltaT = (History[SampleNum] - History[(SampleNum + 1) % HALL_SAMPLE_AVERAGE_SIZE])*portTICK_PERIOD_MS;

		//compute the RPM value
		RPM = (1000*60*HALL_SAMPLE_AVERAGE_SIZE)/((float)DeltaT);

		//update sample pointer
		SampleNum = (SampleNum + 1) % HALL_SAMPLE_AVERAGE_SIZE;
	}

	//give semaphore to indicate activity is present
	xSemaphoreGiveFromISR(HallActive, &xHigherPriorityTaskWoken);

	//yield to other tasks if necesssary
	portYIELD_FROM_ISR(xHigherPriorityTaskWoken);

	//Clear interrupt
	XGpio_InterruptClear(&GPIOInst2,HALL_SENSOR_MASK);
}
