/************************************************************************/
/*																		*/
/* watchdog.h	--	Interface Declarations for watchdog.c				*/
/*																		*/
/************************************************************************/
/*	Author:		Wray Price												*/
/************************************************************************/

#ifndef WATCHDOG_F
#define WATCHDOG_F

#include <stdbool.h>

/* ------------------------------------------------------------ */
/***	int32_t InitWatchDog(void)
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
**		intializes the WatchDog Timer hardware
*/
int32_t InitWatchDog(void);

/* ------------------------------------------------------------ */
/***	void StartWatchDog(void)
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
**		Starts watchdog timer operation
*/	
void StartWatchDog(void);

/* ------------------------------------------------------------ */
/***	void WatchDogKick(void)
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
**		Resets the WatchDog timer when called. The applciation should
**		Call this function periodically to prevent a watchdog reset
*/	
void WatchDogKick(void);

/* ------------------------------------------------------------ */
/***	bool WatchDogExpired(void)
**
**	Parameters:
**		none
**	Return Value:
**		bool: true if the watch dog has expired
**
**	Errors:
**		none
**
**	Description:
**		returns true if the watch dog timer has expired
*/
bool WatchDogExpired(void);


#endif
