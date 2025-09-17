@echo off
:: Use UTF-8 encoding
chcp 65001 >nul

echo.  ================================
echo.   OpenResumaker One-Click Startup Tool
echo.  ================================
echo.
echo  Starting local server...
echo.

:: Create temporary cmd window to run Mongoose
start "OpenResumaker Server" cmd /c "chcp 65001 >nul & mongoose.exe -d dist -l http://0.0.0.0:8000 & pause"

:: Wait for server to start
timeout /t 3 /nobreak >nul

:: Open browser
start http://localhost:8000

echo.
echo  Server started successfully!
echo  When finished, please close the black server window
echo.
pause