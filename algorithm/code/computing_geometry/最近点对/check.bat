@echo off
fpc makedata>nul
fpc closestpair1>nul
fpc closestpair2>nul
:for
  makedata
  closestpair1
  closestpair2
  fc output.out output.ans>nul
  if errorlevel=1 (
    echo WA
    fc output.out output.ans
    pause
    exit
  ) else set /p=AC   <nul
goto for