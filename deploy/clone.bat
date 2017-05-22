@echo off
echo 检出代码 %GitUrl%
git clone %GitUrl% %CodeDir%
echo 检出分支 %Branch%
cd %CodeDir%
git checkout %Branch%
cd %WorkDir%