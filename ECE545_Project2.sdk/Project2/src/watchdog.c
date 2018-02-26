/************************************************************************/
/*																		*/
/* watchdog.c	--	driver for watchdog timer							*/
/*																		*/
/************************************************************************/
/*	Author:		Wray Price												*/
/************************************************************************/
/*  Module Description: 												*/
/*																		*/
/************************************************************************/
/*  Revision History:													*/
/*																		*/
/*	02/25/2018(Wray Price): created										*/
/*																		*/
/************************************************************************/
#include "xwdttb.h"
#include "xparameters.h"
#include "xintc.h"
#include <stdbool.h>

XWdtTb WatchDog;
XWdtTb_Config WatchDogConfig;
extern XIntc IntrptCtlrInst;				// Interrupt Controller instance
static volatile bool WatchDogTimeout = false;

#define WATCHDOG_DEVICE_ID		XPAR_AXI_TIMEBASE_WDT_0_DEVICE_ID
#define WATCHDOG_BASE_ADDR		XPAR_AXI_TIMEBASE_WDT_0_BASEADDR
#define WATCHDOG_WWD_ENA 		XPAR_AXI_TIMEBASE_WDT_0_ENABLE_WINDOW_WDT
#define WATCHDOG_MAX_COUNT		XPAR_AXI_TIMEBASE_WDT_0_MAX_COUNT_WIDTH
#define WATCHDOG_COUNT_WIDTH	XPAR_AXI_TIMEBASE_WDT_0_SST_COUNT_WIDTH
#define WATCHDOG_INTERRUPT		XPAR_MICROBLAZE_0_AXI_INTC_AXI_TIMEBASE_WDT_0_TIMEBASE_INTERRUPT_INTR



int32_t InitWatchDog(void)
{
	int status;

	//initialize XWdtTb pointer
	status = XWdtTb_Initialize(&WatchDog,WATCHDOG_DEVICE_ID);
	if(status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	WatchDogConfig.DeviceId = WATCHDOG_DEVICE_ID;
	WatchDogConfig.BaseAddr = WATCHDOG_BASE_ADDR;
	WatchDogConfig.EnableWinWdt = WATCHDOG_WWD_ENA;
	WatchDogConfig.MaxCountWidth = WATCHDOG_MAX_COUNT;
	WatchDogConfig.SstCountWidth = WATCHDOG_COUNT_WIDTH;

	//initialize hardware module
	status = XWdtTb_CfgInitialize(&WatchDog,&WatchDogConfig,WATCHDOG_BASE_ADDR);
	if(status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

void StartWatchDog(void)
{
	XWdtTb_Start(&WatchDog);
}

void WatchDogKick(void)
{
	XWdtTb_RestartWdt(&WatchDog);
}

bool WatchDogExpired(void)
{
	if(XWdtTb_IsWdtExpired(&WatchDog))
	{
		return true;
	}
	else
	{
		return false;
	}
}
