@echo off
@setlocal

REM -- Batch file to download the video files for the tests

set BASE=http://www.inspirebrowser.org/tests/resources/
set LOCATION=../webroot/resources/

set FILE=big_buck_bunny_480p_h264.mov
set FILE_PATH=%LOCATION%%FILE%
if NOT EXIST %FILE_PATH% (
	REM -- Nope then download it
	echo Check for %FILE_PATH%... not found. Downloading!
	echo.
	wget.exe %BASE%%FILE% -O %FILE_PATH%
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

set FILE=elephantsdream-480-h264-st-aac.mov
set FILE_PATH=%LOCATION%%FILE%
if NOT EXIST %FILE_PATH% (
	REM -- Nope then download it
	echo Check for %FILE_PATH%... not found. Downloading!
	echo.
	wget.exe %BASE%%FILE% -O %FILE_PATH%
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
