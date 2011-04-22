@echo off
@setlocal

REM -- Batch file to download the video files for the tests

set BASE=http://www.inspirebrowser.org/tests/resources/

set FILE="big_buck_bunny_480p_h264.mov"
if NOT EXIST %FILE% (
	REM -- Nope then download it
	echo Check for %FILE%... not found. Downloading!
	echo.
	win32\wget.exe %BASE%%FILE%
	if ERRORLEVEL 1 (
		echo.
		echo **************************** ERROR ***************************************
		echo *   Error downloading %FILE%.                                    *
		echo **************************************************************************
		echo.
		ECHO 1 | CHOICE /C:1234567890 /N > NUL
		goto End
	) else (
		echo.
		echo %FILE% Downloaded
	)
) else (
	echo Check for %FILE%... found.
)

set FILE="elephantsdream-480-h264-st-aac.mov"
if NOT EXIST %FILE% (
	REM -- Nope then download it
	echo Check for %FILE%... not found. Downloading!
	echo.
	win32\wget.exe %BASE%%FILE%
	if ERRORLEVEL 1 (
		echo.
		echo **************************** ERROR ***************************************
		echo *   Error downloading %FILE%.                                    *
		echo **************************************************************************
		echo.
		ECHO 1 | CHOICE /C:1234567890 /N > NUL
		goto End
	) else (
		echo.
		echo %FILE% Downloaded
	)
) else (
	echo Check for %FILE%... found.
)
