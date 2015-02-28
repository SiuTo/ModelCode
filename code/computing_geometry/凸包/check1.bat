@echo off
:for
  makedata
  CH1
  CH2
  fc output.ans output.out>nul
  if errorlevel=1 (
    echo WA
    fc output.ans output.out
    pause
    exit
  ) else set /p=AC   <nul
goto for