# VRChat API - Python Style

This is just a little script that hits up the VR Chat public API. This is the API that the client and website use to pull information about worlds, users, etc.  

The VR Chat devs have stated in their Discord that making use of this API is permitted as long as it's non-malicious. Please be respectful. :)

```
$ vrcapi --help
usage: vrcapi.py [--help] [-w] [-W] [-i] [-I] [-t] [-j] [-u] [-U] [-f] [-F]
                 [-d] [-b] [-B] [-n] [-r] [--setup] [--debug]

....:::: Unofficial Script for pulling info from VRChat API ::::....

optional arguments:
  --help                     Print Usage Info/Help
  -w , --worlds              Search worlds for specified string.
  -W , --world               Search worlds by specific WorldID
  -i, --show-instances       Show details of world instances. (with -W)
  -I, --show-instance-users  Show MORE detail of world. (with -W)
  -t , --tag                 Tags to search for worlds. (with -w)
  -j, --join-links           Include join links in world output.
  -u , --users               Search users for specified string/name.
  -U , --user                Search users by specific UserID
  -f, --friends              List all online friends.
  -F, --pubfriends           List all online friends in non-private worlds.
  -d, --user-detail          More user detail with -U (and -u kindof)
  -b, --user_blocks          Users you have blocked.
  -B, --user_blocked         Users that blocked you.
  -n , --numlimit            Number of results. (Def:10|Max:100)
  -r, --raw                  Print raw json output without parsing.
  --setup                    Input user/password to save to config file.
  --debug                    Enable debug output for some things.
  ```
  ### Common Flags:

  ```bash
  # List friends (-F for non-private)
  vrcapi -f
  # Show people in instance with friend:
  vrcapi -dU ${FriendID}
  # Show people in instances of a world:
  vrcapi -IW ${SorldID}
  ```

### Miscellaneous Features:
* When searching by user or listing friends, it will show the user's true rank by color.
* If they are hiding their rank, it will show their true rank surrounded by green parentheses.
* It will list the world type they're in:
  * P = public
  * F = Friends/Friends+
  * V = Private (Invite/Invite+)
* Shows their status message for fun.

### Planned features:
* Add or remove friends.
* Search friends by last-online date.
* Automatic removal of friends with last online date >X Days (with prompt)
* Clear blocklist with option for moderations >X Days.
* Check messages (friend requests, etc)
* Send messages? Possible, but could be used maliciously.
