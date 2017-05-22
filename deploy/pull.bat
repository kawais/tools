@echo off
echo PULL代码 %GitUrl%
cd %CodeDir%
echo 检出分支 %Branch%
git checkout %Branch%
echo 更新代码
git pull
cd %WorkDir%