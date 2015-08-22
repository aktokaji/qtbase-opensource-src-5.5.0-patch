set SCRIPT=%~0
for /f "delims=\ tokens=*" %%z in ("%SCRIPT%") do (
  set SCRIPT_DRIVE=%%~dz
  set SCRIPT_PATH=%%~pz
  set SCRIPT_CURRENT_DIR=%%~dpz
)
set QT_ROOT=%SCRIPT_CURRENT_DIR%

set CYG_NAME=cygwin64
set CYG_ROOT=C:\%CYG_NAME%
set CYG_PKG=%CYG_ROOT%.pkg
rem set CYG_SITE=http://mirrors.kernel.org/sourceware/cygwin/
set CYG_SITE=http://ftp.iij.ad.jp/pub/cygwin/

rem set PATH=
rem set PATH=%PATH%;%SCRIPT_CURRENT_DIR%\7-Zip
rem set PATH=%PATH%;C:\Program Files\7-Zip
rem set PATH=%PATH%;C:\Program Files (x86)\7-Zip
rem set PATH=%PATH%;%SystemRoot%\System32

REM [refresh %CYG_NAME%]
cd /d %SCRIPT_CURRENT_DIR%

if exist %CYG_ROOT% goto already-installed

REM http://sourceforge.net/projects/gnuwin32/files/wget/
rem C:\GnuWin32\bin\wget.exe --no-clobber http://cygwin.com/setup-x86.exe
C:\GnuWin32\bin\wget.exe --no-clobber --no-check-certificate https://www.cygwin.com/setup-x86_64.exe
rem rmdir /s /q %CYG_PKG%
rmdir /s /q %CYG_ROOT%
mkdir %CYG_PKG%
setup-x86_64.exe -q -W --packages="patch,perl" --root=%CYG_ROOT% --local-package-dir=%CYG_PKG% --no-shortcuts --site=%CYG_SITE%

:already-installed

echo ;%PATH%; | find /C /I ";%CYG_ROOT%\bin;"
if %ERRORLEVEL%==0 goto :exit
echo not found in path!
setx PATH "%PATH%;%CYG_ROOT%\bin"

:exit
cd /d %SCRIPT_CURRENT_DIR%
echo Finished!
pause
