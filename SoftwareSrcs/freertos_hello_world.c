/*
    FreeRTOS V8.2.1 - Copyright (C) 2015 Real Time Engineers Ltd.
    All rights reserved

    VISIT http://www.FreeRTOS.org TO ENSURE YOU ARE USING THE LATEST VERSION.

    This file is part of the FreeRTOS distribution.

    FreeRTOS is free software; you can redistribute it and/or modify it under
    the terms of the GNU General Public License (version 2) as published by the
    Free Software Foundation >>!AND MODIFIED BY!<< the FreeRTOS exception.

    >>!   NOTE: The modification to the GPL is included to allow you to     !<<
    >>!   distribute a combined work that includes FreeRTOS without being   !<<
    >>!   obliged to provide the source code for proprietary components     !<<
    >>!   outside of the FreeRTOS kernel.                                   !<<

    FreeRTOS is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE.  Full license text is available on the following
    link: http://www.freertos.org/a00114.html

    1 tab == 4 spaces!

    ***************************************************************************
     *                                                                       *
     *    Having a problem?  Start by reading the FAQ "My application does   *
     *    not run, what could be wrong?".  Have you defined configASSERT()?  *
     *                                                                       *
     *    http://www.FreeRTOS.org/FAQHelp.html                               *
     *                                                                       *
    ***************************************************************************

    ***************************************************************************
     *                                                                       *
     *    FreeRTOS provides completely free yet professionally developed,    *
     *    robust, strictly quality controlled, supported, and cross          *
     *    platform software that is more than just the market leader, it     *
     *    is the industry's de facto standard.                               *
     *                                                                       *
     *    Help yourself get started quickly while simultaneously helping     *
     *    to support the FreeRTOS project by purchasing a FreeRTOS           *
     *    tutorial book, reference manual, or both:                          *
     *    http://www.FreeRTOS.org/Documentation                              *
     *                                                                       *
    ***************************************************************************

    ***************************************************************************
     *                                                                       *
     *   Investing in training allows your team to be as productive as       *
     *   possible as early as possible, lowering your overall development    *
     *   cost, and enabling you to bring a more robust product to market     *
     *   earlier than would otherwise be possible.  Richard Barry is both    *
     *   the architect and key author of FreeRTOS, and so also the world's   *
     *   leading authority on what is the world's most popular real time     *
     *   kernel for deeply embedded MCU designs.  Obtaining your training    *
     *   from Richard ensures your team will gain directly from his in-depth *
     *   product knowledge and years of usage experience.  Contact Real Time *
     *   Engineers Ltd to enquire about the FreeRTOS Masterclass, presented  *
     *   by Richard Barry:  http://www.FreeRTOS.org/contact
     *                                                                       *
    ***************************************************************************

    ***************************************************************************
     *                                                                       *
     *    You are receiving this top quality software for free.  Please play *
     *    fair and reciprocate by reporting any suspected issues and         *
     *    participating in the community forum:                              *
     *    http://www.FreeRTOS.org/support                                    *
     *                                                                       *
     *    Thank you!                                                         *
     *                                                                       *
    ***************************************************************************

    http://www.FreeRTOS.org - Documentation, books, training, latest versions,
    license and Real Time Engineers Ltd. contact details.

    http://www.FreeRTOS.org/plus - A selection of FreeRTOS ecosystem products,
    including FreeRTOS+Trace - an indispensable productivity tool, a DOS
    compatible FAT file system, and our tiny thread aware UDP/IP stack.

    http://www.FreeRTOS.org/labs - Where new FreeRTOS products go to incubate.
    Come and try FreeRTOS+TCP, our new open source TCP/IP stack for FreeRTOS.

    http://www.OpenRTOS.com - Real Time Engineers ltd license FreeRTOS to High
    Integrity Systems ltd. to sell under the OpenRTOS brand.  Low cost OpenRTOS
    licenses offer ticketed support, indemnification and commercial middleware.

    http://www.SafeRTOS.com - High Integrity Systems also provide a safety
    engineered and independently SIL3 certified version for use in safety and
    mission critical applications that require provable dependability.

    1 tab == 4 spaces!
*/

/* Project2 includes */
#include "Project2Helpers.h"
#include "HWConfigAdapter.h"
/* FreeRTOS includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"
/* Xilinx includes. */
#include "xil_printf.h"
#include <stdio.h>


#define TIMER_ID	1
#define DELAY_10_SECONDS	10000UL
#define DELAY_1_SECOND		1000UL
#define TIMER_CHECK_THRESHOLD	9
/*-----------------------------------------------------------*/


/* The Tx and Rx tasks as described at the top of this file. */
static void InputTask(void *params );
static void PidTask(void *param );
static void DisplayTask(void *params);
//static void vTimerCallback( TimerHandle_t pxTimer );
/*-----------------------------------------------------------*/

/* The queue used by the Tx and Rx tasks, as described at the top of this
file. */
static TaskHandle_t xInputTask;
static TaskHandle_t xPidTask;
static TaskHandle_t xDisplayTask;
static QueueHandle_t xInputToPidQueue = NULL;
static QueueHandle_t xPidToDisplayQueue = NULL;
//static TimerHandle_t xTimer = NULL;
long RxtaskCntr = 0;


int main( void )
{
	//const TickType_t x10seconds = pdMS_TO_TICKS( DELAY_10_SECONDS );

	xil_printf( "Hello from Freertos example main\r\n" );

	InitHardware();

	// Create the two tasks.  The Tx task is given a lower priority than the
	// Rx task, so the Rx task will leave the Blocked state and pre-empt the Tx
	// task as soon as the Tx task places an item in the queue.
	xTaskCreate(InputTask, 					// The function that implements the task.
					NULL, 						// Unused
					1000, 					// The stack allocated to the task.
					NULL, 						// The task parameter is not used, so set to NULL.
					tskIDLE_PRIORITY,			// The task runs at the idle priority.
					&xInputTask);

	xTaskCreate(PidTask,
				 NULL,
				 1000,
				 NULL,
				 tskIDLE_PRIORITY + 1,
				 &xPidTask);

	xTaskCreate(DisplayTask,
				 NULL,
				 1000,
				 NULL,
				 tskIDLE_PRIORITY,
				 &xDisplayTask);


	/* Create the queues used by the tasks.  The Display task has a higher priority
	than the PID task which is higher than the input task, so will each preempt the
	appropriate task before it has a chance to write twice - therefore the queue can
	never have more than one item in it. */
	xInputToPidQueue = xQueueCreate(1, sizeof(STATE_PARAMS));	/* Each space in the queue is large enough to hold a STATE_PARAMS structure. */

	configASSERT(xInputToPidQueue);

	xPidToDisplayQueue = xQueueCreate(1, sizeof(STATE_PARAMS));	/* Each space in the queue is large enough to hold a STATE_PARAMS structure. */

	configASSERT(xPidToDisplayQueue);

	/* Start the tasks and timer running. */
	vTaskStartScheduler();

	/* If all is well, the scheduler will now be running, and the following line
	will never be reached.  If the following line does execute, then there was
	insufficient FreeRTOS heap memory available for the idle and/or timer tasks
	to be created.  See the memory management section on the FreeRTOS web site
	for more details. */
	for( ;; );
}

static void InputTask(void *params )
{
	int16_t rotaryCount;
	uint16_t slideSwitches;
	BUTTON_STATE buttons;

	STATE_PARAMS state;

	bool clearRotaryCountAfterRead = TRUE;
	bool forceStateReset = TRUE; //Flag to initialize state

	BaseType_t queueStatus;

	while(TRUE)
	{
		rotaryCount = GetRotaryCount(clearRotaryCountAfterRead);
		slideSwitches = GetSwitches();
		buttons = GetPushButtons();
		ModifyState(slideSwitches, buttons, rotaryCount, &state, forceStateReset);
		forceStateReset = FALSE;
		queueStatus = xQueueOverwrite(xInputToPidQueue, &state);
		configASSERT(queueStatus == pdTRUE);
		vTaskDelay(pdMS_TO_TICKS(150));
	}
}

static void PidTask(void *params)
{
	bool initialized = FALSE;
	STATE_PARAMS state;
	BaseType_t queueStatus;
	while(TRUE)
	{
		//Read
		queueStatus = xQueueReceive(xInputToPidQueue, &state, 0);
		if(!initialized && queueStatus == pdTRUE)
		{
			initialized = TRUE;
		}
		if(initialized)
		{
			state.actualRpm = GetMotorRpm();
			RPM_TYPE driveRpm = PIDAlgorithm(&state);
			SetMotorRpm(driveRpm);
			//Forward state onto Display Task
			xQueueOverwrite(xPidToDisplayQueue, (void*) &state);
		}
		vTaskDelay(pdMS_TO_TICKS(10));
	}
}

static void DisplayTask(void *params)
{
	STATE_PARAMS state;
	uint16_t leds;
	BaseType_t queueStatus;
	bool isInitialized = FALSE;
	while(TRUE)
	{
		queueStatus = xQueueReceive(xPidToDisplayQueue, (void*) &state, pdMS_TO_TICKS(100));
		if(isInitialized || queueStatus == pdTRUE)
		{
			OLEDSetDisplay(GetOLEDDisplayHandle(), &state);
			leds = FormatLEDOutput(state.select);
			SetLEDs(leds);
			isInitialized = TRUE;
		}
	}
}




