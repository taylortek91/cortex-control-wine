@echo off
if "%CORTEX_CONTROL_HOST_ONLINE%"=="1" (
  echo 1
) else (
  echo 0
)
exit /b 0
