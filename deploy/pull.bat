@echo off
echo PULL���� %GitUrl%
cd %CodeDir%
echo �����֧ %Branch%
git checkout %Branch%
echo ���´���
git pull
cd %WorkDir%