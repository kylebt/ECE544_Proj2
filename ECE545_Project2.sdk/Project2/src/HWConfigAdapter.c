/*
 * HWConfigAdapter.cpp
 *
 *  Created on: Feb 21, 2018
 *      Author: Kyle
 */

#include "HWConfigAdapter.h"
#include "pmodhb3.h"
#include "xparameters.h"
#include "pmodENC.h"
#include "xgpio.h"
#include "xintc.h"
#include "watchdog.h"

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

	InitPmodHB3();

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

RPM_TYPE GetMotorRpm()
{
	return GetRPM();
}

void SetMotorRpm(RPM_TYPE rpm)
{
	float pwm = (rpm > 100) ? 100 : rpm;
	pwm = pwm/100;
	SetPWM(pwm);
}
