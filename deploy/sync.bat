set Dry=
if "%1"=="" (
  set Dry=--dry-run
)
rem set cmd=rsync %Dry%  --chmod=a=r,u+w,D+x -rlDzvP --exclude-from=exclude.txt -e "ssh -i cwrsync" %CodeDir% %HostDir%
rem set cmd=rsync %Dry%  --chmod=a=r,u+w,D+x -azv --exclude-from=exclude.txt  %CodeDir% /cygdrive/d/backup
set excludeFile=exclude.txt
if exist exclude.%RsyncDir%.txt (
  set excludeFile=exclude.%RsyncDir%.txt
)
set cmd=rsync %Dry% --delete --chmod=a=r,u+w,D+x -rlDzvPc  --exclude-from=%excludeFile% %CodeDir% %HostDir%

%cmd%