REM Tool for automatically mounting and dismounting a RAM Disk for VRChat.

REM   Will dismount any existing RAM Disk and set up symlinks for Cache Dirs
REM      to point to an alternate location ( eg external disk )
REM   Will then pause and ask if you want to create the RAM Disk (again).
REM   Will create RAM Disk and re-create symlinks of cache dirs to the RAM Disk.

REM  Can also be used as a quick way to clear the cache since the contents
REM    of the RAM Disk are deleted in step 1.

REM  Requires: https://sourceforge.net/projects/imdisk-toolkit/

@echo off

REM ---------------------------------------------------------------------------
REM Must be run as Administrator or else imdisk won't dismount properly and
REM  will consume all your RAM when new disks are created.

net session > nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO you are Administrator
) ELSE (
    ECHO you are NOT Administrator. Exiting...
    pause
    EXIT /B 1
)
REM ---------------------------------------------------------------------------
REM Set the paths in mklinks below to reflect the normal, non-ramdisk location of cache files.
REM   eg: External drive to save SSD wear on main drive, etc.
REM If default location isn't changed, just name them something else on the main drive.
REM   eg: \VRChat\HTTPCache_Real

imdisk -d -m V:
rmdir C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\HTTPCache
rmdir C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\HTTPCache-WindowsPlayer
rmdir C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\VRCHTTPCache
rmdir C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\Cache-WindowsPlayer
mklink /d C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\HTTPCache D:\VRChat\HTTPCache
mklink /d C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\HTTPCache-WindowsPlayer D:\VRChat\HTTPCache-WindowsPlayer
mklink /d C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\VRCHTTPCache D:\VRChat\VRCHTTPCache
mklink /d C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\Cache-WindowsPlayer D:\VRChat\Cache-WindowsPlayer

echo Disk Unmounted.  Enter to re-mount.  Exit to skip.
pause

REM ---------------------------------------------------------------------------
REM Using drive V: by default.  If this is already in use, change it to an
REM   unused drive letter in the commands below.  Tweak size if necessary.

imdisk -a -s 12G -m V: -o awe -p "/fs:ntfs /q /y"
mkdir V:\VRChat
mkdir V:\VRChat\HTTPCache
mkdir V:\VRChat\HTTPCache-WindowsPlayer
mkdir V:\VRChat\VRCHTTPCache
mkdir V:\VRChat\Cache-WindowsPlayer
rmdir C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\HTTPCache
rmdir C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\HTTPCache-WindowsPlayer
rmdir C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\VRCHTTPCache
rmdir C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\Cache-WindowsPlayer
mklink /d C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\HTTPCache V:\VRChat\HTTPCache
mklink /d C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\HTTPCache-WindowsPlayer V:\VRChat\HTTPCache-WindowsPlayer
mklink /d C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\VRCHTTPCache V:\VRChat\VRCHTTPCache
mklink /d C:\Users\%USERNAME%\AppData\LocalLow\VRChat\vrchat\Cache-WindowsPlayer V:\VRChat\Cache-WindowsPlayer
