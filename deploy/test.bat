rsync --dry-run -zrv --exclude-from=exclude.txt %CodeDir% %HostDir%
@pause