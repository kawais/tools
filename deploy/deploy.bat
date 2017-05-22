@echo off
cls
rsync --version >nul
if %ERRORLEVEL% GTR 0 (
  echo ���Ȱ�װrsync������ϵͳPATH��
  pause
  exit
)


SETLOCAL 
set CodeBase=code
set GitBase=git@192.168.18.18:

set HostBaseDir=/var/www

set Proj=
set RsyncDir=
set Branch=
set WorkDir=%~dp0
set Erase=0
goto input

goto end

:input
set /p Proj=������Ŀ��:
if "%Proj%"=="" (
  goto input
)
set /p RsyncDir=����RsyncĿ¼:
if "%RsyncDir%"=="" (
  set RsyncDir=%Proj%
)
set /p Branch=�����֧ [master]:
if "%Branch%"=="" (
  set Branch=master
)
set /p HostIp=������ [test]:
if "%HostIp%"=="prod" (
  set HostIp=10.25.39.178
) else (
  set HostIp=10.25.251.137
)


set CodeDir=%CodeBase%/%Proj%/
set GitUrl=%GitBase%/%Proj%.git
set Host=%RsyncDir%@%HostIp%
set HostDir=%Host%::%RsyncDir%

if exist "%CodeDir%" (
  set /p Erase=������� [0]:
  if "%Erase%"=="" (
    set Erase=0
  )
)


if %Erase%==1 (
  goto clean
  timeout /t 3
)
goto update

:clean
call clean.bat


:update

if exist "%CodeDir%" (
  call pull.bat
) else (
  call clone.bat
)
goto getver
goto dryrun

:getver
call lastver.bat

:dryrun
echo ������ļ�
call sync.bat 
set /p Sync=�Ƿ�ͬ��[0]:

if "%Sync%"=="1" (
  goto sync
)else (
  goto end
)

:sync
call sync.bat 1
goto end



:end

ENDLOCAL 
echo Done.
pause