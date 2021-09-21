@echo off
echo Running oobe
oobe\windeploy
echo Creating user a
net user /add a
echo Creating group
net localgroup /add users a
echo Giving user a admin privillage
net localgroup /add Administrators a
echo Performing registry actions
reg import reg2.reg
echo Exiting
exit