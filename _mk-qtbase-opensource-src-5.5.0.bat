set SCRIPT=%~0
for /f "delims=\ tokens=*" %%z in ("%SCRIPT%") do (
  set SCRIPT_DRIVE=%%~dz
  set SCRIPT_PATH=%%~pz
  set SCRIPT_CURRENT_DIR=%%~dpz
)
set QT_ROOT=%SCRIPT_CURRENT_DIR%

set QT_NAME=qtbase-opensource-src-5.5.0
set QT_MINGW=mingw-qt-5.4.0-as-is
set QT_MSYS=msys-2015-0114
set QT_ARCH=qtbase-opensource-src-5.5.0
set QT_RUBY=ruby-1.9.3-p551-i386-mingw32

set JOM_PATH=C:\Qt\Qt5.5.0\Tools\QtCreator\bin\jom.exe

set COMPILER_ARCH=win32-msvc2013
set COMPILER_HOME=C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC
set COMPILER_MAKE=nmake.exe

if exist "%JOM_PATH%" set COMPILER_MAKE=%JOM_PATH%

echo %JOM_PATH%
echo %COMPILER_MAKE%

set CYG_NAME=cygwin-for-5.4.0

set MSYS_PATCH=%QT_ROOT%%QT_MSYS%\bin\patch.exe
set MSYS_SED=%QT_ROOT%%QT_MSYS%\bin\sed.exe
set MSYS_CP=%QT_ROOT%%QT_MSYS%\bin\cp.exe
set MSYS_RM=%QT_ROOT%%QT_MSYS%\bin\rm.exe
set MSYS_TEE=%QT_ROOT%%QT_MSYS%\bin\tee.exe

set QT_PERL=strawberry-perl-no64-5.20.1.1-32bit-portable
set QT_RUBY=ruby-1.9.3-p551-i386-mingw32

set PATH=
set PATH=%PATH%;%QT_ROOT%7-Zip
set PATH=%PATH%;C:\Program Files\7-Zip
set PATH=%PATH%;C:\Program Files (x86)\7-Zip
set PATH=%PATH%;%SystemRoot%\System32
set PATH=%PATH%;C:\GnuWin32\bin
set PATH=%PATH%;C:\cygwin64\bin

set PATH=%QT_ROOT%%QT_PERL%\perl\bin;%PATH%
set PATH=%QT_ROOT%%QT_RUBY%\bin;%PATH%

cd /d %QT_ROOT%
echo START(1) %date%-%time% >> %QT_ROOT%%QT_NAME%.log

rem pause
rem goto exit

set INCLUDE=
set LIB=
set LIBPATH=
call "%COMPILER_HOME%\\vcvarsall.bat" x86
echo on

if exist %QT_ROOT%%QT_NAME%\bin\qmake.exe goto skip

cd /d %QT_ROOT%
echo START(2) %date%-%time% >> %QT_ROOT%%QT_NAME%.log
cd /d %QT_ROOT%%QT_NAME%
cd include
cp -rp %QT_ROOT%openssl-1.0.1e-bin\include\openssl .

rem goto exit

cd /d %QT_ROOT%
echo START(3) %date%-%time% >> %QT_ROOT%%QT_NAME%.log
cd /d %QT_ROOT%%QT_NAME%
configure.exe -debug-and-release -opensource -confirm-license -platform win32-msvc2013 -target xp -qmake -prefix C:\Qt\Qt5.5.0\5.5\msvc2013 -no-icu -no-angle -opengl desktop -nomake tests -nomake examples -ssl -openssl

:skip

if exist %QT_ROOT%%QT_NAME%\qtbase\translations\assistant_ja.qm goto build-qtwebkit

REM [build %QT_NAME%]
cd /d %QT_ROOT%
echo START(4) %date%-%time% >> %QT_ROOT%%QT_NAME%.log
cd /d %QT_ROOT%%QT_NAME%
%COMPILER_MAKE%

:build-qtwebkit

:exit
cd /d %QT_ROOT%
echo END      %date%-%time% >> %QT_ROOT%%QT_NAME%.log
