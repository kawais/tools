@echo off
echo ������� %GitUrl%
git clone %GitUrl% %CodeDir%
echo �����֧ %Branch%
cd %CodeDir%
git checkout %Branch%
cd %WorkDir%