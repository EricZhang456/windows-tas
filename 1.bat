@echo off
rem inspired by enderman on youtube
echo Partioning the disk and mounting the file system
(echo select disk 0
echo clean
echo convert gpt
echo create part efi size=500
echo format fs=fat32 quick
echo assign letter w
echo create part primary
echo format fs=ntfs quick
echo assign letter c
echo exit
)  | diskpart
rem whoa i didn't know windows had piping until i found this on stack overflow
echo Installing base system to the mounted file system
D:
cd sources
dism /apply-image /imagefile:install.wim /index:1 /applydir:C:\
echo Installing bootloader
rem I literally have no idea what I am doing
rem Bootrec doesn't work, bcdboot can't seem to install properly
rem IDK anything about all these
rem I am done with BIOS
bcdboot C:\Windows /s W:
echo Performing registry actions
reg load HKLM\SOFT C:\Windows\system32\config\SOFTWARE
reg load HKLM\SYS C:\Windows\system32\config\system
reg add HKLM\SOFT\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 1
rem change E with the drive letter that you have this script and other stuff in it
reg import E:\reg.reg
echo Copying second part of the script to the file system
copy E:\2.bat C:\
copy E:\reg2.reg C:\
echo Rebooting
wpeutil reboot
