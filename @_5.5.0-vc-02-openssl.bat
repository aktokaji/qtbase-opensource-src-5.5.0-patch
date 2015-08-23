rem set QT_NAME=%1
rem if "%QT_NAME%"=="" exit
rem echo QT_NAME=%QT_NAME%

set SCRIPT=%~0
for /f "delims=\ tokens=*" %%z in ("%SCRIPT%") do (
  set SCRIPT_DRIVE=%%~dz
  set SCRIPT_PATH=%%~pz
  set SCRIPT_CURRENT_DIR=%%~dpz
)
set QT_ROOT=%SCRIPT_CURRENT_DIR%

set PATH=
set PATH=%PATH%;%QT_ROOT%7-Zip
set PATH=%PATH%;C:\Program Files\7-Zip
set PATH=%PATH%;C:\Program Files (x86)\7-Zip
set PATH=%PATH%;%SystemRoot%\System32
set PATH=%PATH%;C:\cygwin64\bin

call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86
echo on

if exist %SCRIPT_CURRENT_DIR%%OSSL_NAME%-bin goto already-built

REM [refresh OSSL]
REM set OSSL_NAME=openssl-1.0.1k
REM set OSSL_URL=https://www.openssl.org/source/%OSSL_NAME%.tar.gz
set OSSL_NAME=openssl-1.0.1e
set OSSL_URL=https://www.openssl.org/source/old/1.0.1/%OSSL_NAME%.tar.gz
rem          https://www.openssl.org/source/old/1.0.1/openssl-1.0.1e.tar.gz
cd %SCRIPT_CURRENT_DIR%
REM http://sourceforge.net/projects/gnuwin32/files/wget/
C:\GnuWin32\bin\wget.exe --no-clobber --no-check-certificate %OSSL_URL%
rmdir /s /q %OSSL_NAME%
tar zxvf %OSSL_NAME%.tar.gz
rem 7z x %OSSL_NAME%.tar.gz
rem 7z x %OSSL_NAME%.tar
rem del  %OSSL_NAME%.tar

perl --version

REM [build OSSL]

cd %SCRIPT_CURRENT_DIR%%OSSL_NAME%
perl Configure VC-WIN32 --prefix=%SCRIPT_CURRENT_DIR%%OSSL_NAME%-bin
call ms\do_ms.bat
rem nmake -f ms\nt.mak
rem nmake -f ms\nt.mak install
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

:already-built

:exit
cd %QT_ROOT%
pause
