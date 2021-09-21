@echo off
rem inspired by enderman on youtube
echo Partioning the disk and mounting the filesystem
(echo select disk 0
echo clean
echo convert mbr
echo create part primary
echo format fs=ntfs quick
echo assign letter c
echo exit
)  | diskpart
rem whoa i didn't know windows had piping until i found this on stack overflow
echo Installing base system to the mounted filesystem
D:
cd sources
dism /apply-image /imagefile:install.wim /index:1 /applydir:C:\
echo Installing bootloader
bootrec /fixmbr
echo Performing registry actions
reg load HKLM\SOFT C:\Windows\system32\config\SOFTWARE
reg load HKLM\SYS C:\Windows\system32\config\system
reg add HKLM\SOFT\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 1
reg import E:\reg.reg
echo Copying second part of the script to the filesystem
copy E:\2.bat C:\
copy E:\reg2.reg C:\
rem pause
echo Rebooting
wpeutil reboot
