@echo off
:for
  make
  LCA
  LCA2
  fc LCA.out LCA.ans>nul
  if errorlevel=1 (
    echo WA
    fc LCA.out LCA.ans
    pause
    exit
  ) else set /p=AC   <nul
goto for