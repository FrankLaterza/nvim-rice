@echo off

REM remove current config
rmdir /s /q "%LOCALAPPDATA%\nvim" 2>nul

REM copy new config
xcopy /e /i /h /y "nvim" "%LOCALAPPDATA%\nvim"

echo Installation complete!
pause