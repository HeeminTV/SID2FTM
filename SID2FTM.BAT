@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET "SIDDUMPPATH="
SET "LENGTH=180"
SET "ROWS=256"
SET "LOGTYPE=0"
SET "SIDPATH="
IF "%~1"=="" (
	ECHO 		SID2FTM
	ECHO 		By HeeminYT 2025
	ECHO.
	ECHO Usage:
	ECHO --------------------------------------------------------------
	ECHO   %~nx0 ^<Path of your .SID file^> [Options]
	ECHO.
	REM echo 	/INFO		-- Prints information about the current script in ini format.
	REM echo 	/VER		-- Prints only the version and exits.
	echo 	/NOLOG		-- Prints nothing during conversion if this flag is set.
	echo.
	echo 	/LEN ^<num^>	-- Specifies the number of seconds to be recorded. Default vaule is 180
	echo 	/ROWS ^<num^>	-- Specifies the number of rows in one frame. Default / Maximum vaule is 256
	
	EXIT /B 0
)

IF NOT EXIST "%~1" CALL :INIGEN ERR NOSUCHFILE 2
!SIDDUMPPATH!siddump.exe "%~1" -t0 >NUL
IF !ERRORLEVEL! EQU 1 CALL :INIGEN ERR INVALIDFILE 13
SET "SIDPATH=%~1"
:PARAMETERSLOOP
IF NOT "%~2"=="" (
	IF /i "%~2"=="/NOLOG" SET "LOGTYPE=1"
	IF /i "%~2"=="/LEN" SET "LENGTH=%~3"
	IF /i "%~2"=="/ROWS" SET "ROWS=%~3"
	SHIFT
	GOTO :PARAMETERSLOOP
)
IF "!LOGTYPE!"=="" CALL :INIGEN ERR INVALIDARG 1
IF "!LENGTH!"=="" CALL :INIGEN ERR INVALIDARG 1
IF "!ROWS!"=="" CALL :INIGEN ERR INVALIDARG 1
EXIT /B 0

:INIGEN TYPE STRING ERRORLEVEL SUBERR
IF "%~1"=="ERR" (
	ECHO [Error]
	ECHO ERROR=%~2
	ECHO ERRCODE=%~3
	EXIT %~3
)

