@echo off
SET "SRC=C:\Users\m10921371\data\hrrr"
SET "DST=D:\climate_data"

IF NOT EXIST "%DST%" MKDIR "%DST%"

:LOOP
  REM find newest folder
  SET "LATEST="
  FOR /F "delims=" %%D IN ('dir "%SRC%" /AD /B /O-D') DO (
    SET "LATEST=%%D"
    GOTO :FOUND2
  )
:FOUND2

  REM Robocopy each non-newest directory
  FOR /D %%F IN ("%SRC%\*") DO (
    IF /I NOT "%%~nxF"=="%LATEST%" (
      ECHO [%DATE% %TIME%] Robocopying %%~nxF…
      robocopy "%SRC%\%%~nxF" "%DST%\%%~nxF" /E /MOV /R:3 /W:5
      REM remove now-empty source folder
      rd "%SRC%\%%~nxF" 2>nul
    ) ELSE (
      ECHO   Skipping newest folder %%~nxF
    )
  )

  ECHO [%DATE% %TIME%] Sleeping 1 hour…
  TIMEOUT /T 3600 /NOBREAK >NUL
GOTO LOOP
