@echo off
cls
rsync --version >nul
if %ERRORLEVEL% GTR 0 (
  echo 请先安装rsync并加入系统PATH中
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
set /p Proj=输入项目名:
if "%Proj%"=="" (
  goto input
)
set /p RsyncDir=输入Rsync目录:
if "%RsyncDir%"=="" (
  set RsyncDir=%Proj%
)
set /p Branch=输入分支 [master]:
if "%Branch%"=="" (
  set Branch=master
)
set /p HostIp=发布到 [test]:
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
  set /p Erase=清除代码 [0]:
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
echo 需更新文件
call sync.bat 
set /p Sync=是否同步[0]:

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