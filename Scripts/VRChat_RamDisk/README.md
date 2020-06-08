# VRChat Ram Disk
Create a RAM Disk for storing VRChat's cache files in.  
  *(Also see notes in the `.bat` file)*

#### Should I use a RAM Disk?:
First off, I urge people to use this script as a template rather than running it blindly.  Understand it first and adapt it to your usage.  I accept no responsibility if bad things happen. :D  That said, I've been using this for quite a while with no issue.

**Pros**:
 * Very fast read/write time for cache files.
 * Stop wearing out SSD drives with tons of read/write
 * Very quick cache clearing.
 * Avoid filling up your system disk with cache.

**Cons**:
 * Cache is not kept through reboots.
  * May be desirable if your internet is slow.
 * You need a *lot* of RAM.
  * I have 32G and dedicate 12G to VRChat cache.
 * Can store less total cache compared to much larger disk.  

#### Usage:
**Requirement**: Install [ImDisk Toolkit](https://sourceforge.net/projects/imdisk-toolkit/) first.

1. Edit included `.bat` file to the correct paths.
 * Note: Default path doesn *not* have to be on `C:` drive.  I use an external disk by default with option to create a RAM disk.
2. Ensure you have the `V:` drive open. If not, change the imdisk command to use a different letter.
3. Right click the `.bat` file and run as administrator.

The `.bat` file will:
1. Delete the `V:` RAM Disk first (clears cache). Disabling RAM Disk.
2. Ensure the default cache directories on `C:` don't exist.
3. SymLink the `C:` drive cache to an external `D:` drive (unless edited).
4. Wait for user input.  Pressing any key here will set up the RAM Disk.
5. If user continues, it will create a `V:` drive with `12GB` of space (Default) and change the SymLinks to be on this new drive.

#### Problems:
Rarely when running the script, it doesn't actually remove/dismount the `V:` drive, so if you continue, it creates a second 12G RAM disk for a total of `24G` used.  Might want to confirm that the drive is actually gone before pressing a key to continue.

Not entirely sure what causes this, though I suspect the system is keeping files open in the drive that prevent dismounting.
