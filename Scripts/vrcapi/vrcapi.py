#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# Importing some crap we need.  If the script gripes about not having these
#  modules, you should probably install them.  ~_O
import requests
from pygments import highlight, lexers, formatters
import configparser
import argparse
import json
import re
import sys
import os

## To do:
# Clear your blocklist, possibly option for older than X months/days.
# Friend List Purge based on last-online time.
# Send friend requests/Remove Friends.
# Send and check messages? Option to read message from file (for ascii art)

## Set the config file here:
config_file=os.path.expanduser('~/.vrcapi.conf')

############### Shouldn't need to touch this stuff ############################
# "HURR, he posted his API key to GitHub! XD"
#  This is the public API key that everyone uses:
#        https://api.vrchat.cloud/api/1/config/
apiurl = "https://api.vrchat.cloud/api/1"
apikey = "apiKey=JlE5Jldo5Jibnk5O5hTx6XVqsJu4WJ26"

# Doubt we'll need this, but let's keep things civil.
os.nice(19)

# colors for prettiness & readability
col_bold="\033[1m"
col_norm="\033[0m"
col_red="\033[31m"
col_green="\033[32m"

# Lets's set up a parser to specify search types.
description_text = '\033[1m....:::: Unofficial Script for pulling info from VRChat API ::::....\033[0m'

parser = argparse.ArgumentParser(description=description_text, epilog="Bugs? Hit up \033[1mEremite#8888\033[0m on Discord. (or RTFM)",
                                 formatter_class=lambda prog: argparse.HelpFormatter(prog, max_help_position=30), add_help=False)

parser.add_argument("--help", help="Print Usage Info/Help", action='store_true')
parser.add_argument("-w", "--worlds", help="Search worlds for specified string.", dest="world_search", metavar="")
parser.add_argument("-W", "--world", help="Search worlds by specific WorldID", dest="worldid_search", metavar="")
parser.add_argument("-i", "--show-instances", help="Show details of world instances. (with -W)",action="store_true")
parser.add_argument("-I", "--show-instance-users", help="Show MORE detail of world. (with -W)", action="store_true")
parser.add_argument("-t", "--tag", help="Tags to search for worlds. (with -w)", dest="world_tag", metavar='')
parser.add_argument("-j", "--join-links", help="Include join links in world output.", action="store_true")
parser.add_argument("-u", "--users", help="Search users for specified string/name.", dest="user_search", metavar="")
parser.add_argument("-U", "--user", help="Search users by specific UserID", dest="userid_search", metavar="")
parser.add_argument("-f", "--friends", help="List all online friends.", action="store_true")
parser.add_argument("-F", "--pubfriends", help="List all online friends in non-private worlds.", action="store_true")
parser.add_argument("-p", "--purgeable", help="List friends offline since X days.", dest="purgeabledays", metavar='')
parser.add_argument("-P", "--purge", help="Purge friends offline since X days. With Confirmation.", dest="purgedays", metavar='')
parser.add_argument("-d", "--user-detail", help="More user detail with -U (and -u kindof)", action="store_true")
parser.add_argument("-b", "--user_blocks", help="Users you have blocked.", action="store_true")
parser.add_argument("-B", "--user_blocked", help="Users that blocked you.", action="store_true")
parser.add_argument("-n", "--numlimit", help="Number of results. (Def:10|Max:100)", type=int, dest="numlimit", metavar="")
parser.add_argument("-r", "--raw", help="Print raw json output without parsing.", action="store_true")
parser.add_argument("--setup", help="Input user/password to save to config file.", action="store_true")
parser.add_argument("--debug", dest="debug", help="Enable debug output for some things.", action='store_true')
args = parser.parse_args()


# Print help if no arguments are supplied.
if (args.help):
    parser.print_help()
    sys.exit(1)


# See if we can read the conf file:
config = configparser.ConfigParser()
if not args.setup:
    try:
        config.read(config_file)
        authkey=config.get('credentials', 'authkey')
        headers = {'Authorization': 'Basic ' + authkey }
    except:
        print("No config file or auth key found. Run this: \033[1mvrcapi --setup\033[0m")
        sys.exit()



## Some functions for doing the API hits.

# Search world by search term (keyword, author name, etc)
def worldsearch(term):
    targeturi = apiurl + "/worlds/?" + apikey + '&search="' + term + '"'
    targeturi = check_extra_args(targeturi)

    if args.debug:
      print("\033[1mURI: \033[0m" + targeturi )

    rjson = requests.get(targeturi, headers=headers)
    rjson=json.loads(rjson.content.decode('utf-8'))

    if args.raw:
        print_raw_json(rjson)
    else:
        parse_multiple_worlds(rjson)

# search by World ID
def worldidsearch(wid):
    targeturi = apiurl + "/worlds/" + wid + "/?" + apikey
    targeturi = check_extra_args(targeturi)

    if args.debug:
      print("\033[1mURI: \033[0m" + targeturi)

    rjson = requests.get(targeturi, headers=headers)
    rjson=json.loads(rjson.content.decode('utf-8'))

    if args.raw:
        print_raw_json(rjson)
    else:
        parse_world(rjson)

# Search users by name, etc.
def usersearch(term):
    targeturi = 'https://api.vrchat.cloud/api/1/users/?search=' + term + '&' + apikey
    targeturi = check_extra_args(targeturi)

    if args.debug:
        print("\033[1mURI: \033[0m" + targeturi)

    rjson = requests.get(targeturi, headers=headers)
    rjson = json.loads(rjson.content.decode('utf-8'))

    if args.raw:
        print_raw_json(rjson)
    else:
        parse_multiple_users(rjson)

# Search users by userID
def useridsearch(uid):
    targeturi = 'https://api.vrchat.cloud/api/1/users/' + uid + '/?' + apikey
    targeturi = check_extra_args(targeturi)

    rjson = requests.get(targeturi, headers=headers)
    rjson = json.loads(rjson.content.decode('utf-8'))

    if args.raw:
        print_raw_json(rjson)
    else:
        parse_user(rjson, args.user_detail)

# Pull a list of currently online friends.
def listfriends():
    targeturi = 'https://api.vrchat.cloud/api/1/auth/user/friends/?' + apikey
    targeturi = check_extra_args(targeturi)

    rjson = requests.get(targeturi, headers=headers)
    rjson = json.loads(rjson.content.decode('utf-8'))

    if args.pubfriends:
        rjson = [f for f in rjson if f['location'] != 'private']

    if args.raw:
        print_raw_json(rjson)
    else:
        parse_multiple_users(rjson, args.user_detail)

## Some helper functions for formatting worlds/users:

# Wrapper for parse_world for handling multiple worlds in json.
def parse_multiple_worlds(wjson):
    for w in wjson:
        parse_world(w)

# Output info about a world:
def parse_world(w):
    # If instances is defined (-W search), set the number here
    # Else set it to '?' if it doesn't exist (-w search)
    try:
        instances = len(w['instances'])
    except:
        instances = '?'

    # If -j is specified, print off a link to launch the world.
    if args.join_links:
        launchlink = "\nhttps://www.vrchat.net/launch?worldId=" + w['id']
    else:
        launchlink = ''

    # Print off some information about the world all pretty-like.
    print('''\033[1mName: \033[0m\033[1;36m{0:<48}\033[0m \033[1mAuthor:\033[0m {6:<38}
{1:<46} \033[1mOcc:\033[0m {2:<3} \033[1mCap:\033[0m {3:<3} \033[1mInst:\033[0m {4:<3} \033[1mFav:\033[0m {5:<5} Heat:{8:<3} Visits: {9}  {7}
'''.format(w['name'], w['id'], w['occupants'], w['capacity'], instances, w['favorites'], w['authorName'], launchlink, w['heat'], w['visits']
    ))

    # If -W is specified and -I or -i are specified, we need to get a list of instances.
    if args.worldid_search and ( args.show_instances or args.show_instance_users ):
        if args.debug:
            print(w['instances'])
        try:
            for i in w['instances']:
                if "~hidden" in i[0]:
                    iid = "\033[1;36m" + i[0].split("~")[0] + "\033[0m"
                else:
                    iid = "\033[1;32m" + i[0] + "\033[0m"

                print('''\033[1;36m{0}\n(\033[1m{1:>2} )\033[0m  ID: {2}'''.format('-'*50, i[1], iid))

                # If -I is specified instead of just -i, we also need to get a list of users in all instances.
                if args.show_instance_users:
                    userlist = getinstanceusers(w['id'], i[0])

                    try:
                        for u in userlist['users']:
                            parse_user(u)
                    except:
                        pass

                # Finally print a launch link if requested:
                print("\033[1mLaunch:\033[0m https://www.vrchat.net/launch?worldId=" + w['id'] +
                   '&ref=vrchat.com&instanceId=' + i[0])
        except:
            print("Something broke parsing the instances.", sys.exc_info())

# Get list of users in an instance.
def getinstanceusers(wid, instance):
    targeturi = apiurl + '/worlds/' + wid + '/' + instance + '/?' + apikey
    if args.debug:
        print(targeturi)
    userlist = requests.get(targeturi, headers=headers)
    userlist = json.loads(userlist.content.decode('utf-8'))
    return(userlist)

##  User parsers
def parse_multiple_users(ujson, detail=False):
    for u in sorted(ujson, key=lambda u: u['displayName'].lower()):
        parse_user(u, detail=detail)

def parse_user(u, detail=False):
    # Give them a color based on their new trust rank.
    tags = u['tags']
    if "system_trust_legend" in tags:
        rank="\033[0;33mVeteran"
        displayname = "\033[1;33m" + u['displayName'] + '\033[0m'
    elif "system_trust_veteran" in tags:
        rank="\033[0;35mTrusted"
        displayname = "\033[1;35m" + u['displayName'] + '\033[0m'
    elif "system_trust_trusted" in tags:
        rank="\033[0;31mKnown"
        displayname = "\033[1;31m" + u['displayName'] + '\033[0m'
    elif "system_trust_known" in tags:
        rank="\033[0;32mUser"
        displayname = "\033[1;32m" + u['displayName'] + '\033[0m'
    elif "system_trust_basic" in tags:
        rank="\033[0;34mNew User"
        displayname = "\033[1;34m" + u['displayName'] + '\033[0m'
    else:
        rank="\033[1;30mVisitor"
        displayname = "\033[1;30m" + u['displayName'] + '\033[0m'

    incognitos=['system_trust_trusted', 'system_trust_veteran', 'system_trust_legend']
    if "show_social_rank" not in tags and any(i in tags for i in incognitos):
        socialcolor='\033[0;32m'
    else:
        socialcolor=""

    # Try to grab their status description_text
    try:
        udesc = u['statusDescription']
    except:
        udesc = ''

    # Show an eyeball if they're in a private world to see who's joinable.
    try:
        if u['location'] == "private":
            worldicon="\033[1;31mV\033[0m"
        elif '~hidden' in u['location']:
            worldicon="\033[1;36mF\033[0m"
        elif u['location'] == 'offline':
            worldicon="\033[1;37mX\033[0m"
        else:
            worldicon="\033[1;32mP\033[0m"
    except:
        worldicon="?"

    uid = u['id']
    # Output all pretty-like.
    print('''{0:<12} \033[1m({1:^16}\033[0;1m)     {2:<35} {3:<42} \033[0;36m{4}\033[0m'''.format(worldicon, rank, displayname, uid, udesc).replace('(',socialcolor + '(').replace(')',socialcolor + ')'))

    if detail is True and u['location'] != '':
        if u['location'] == 'private':
            print("\t👁 \033[1;31m Private World \033[0m👁")
        else:
            print("\n")
            worldidsearch(u['location'].split(':')[0])

            if args.debug:
                print(u['location'].split(':')[1])

            try:
                re.match('^[0-9]*$', u['location'].split(':')[1])[0]
                print('\033[1;32m\t 𝓟   Public Instance   𝓟\033[0m')
            except:
                print('\033[1;35m\t 𝓕 ✚  Friends+ Instance  𝓕 ✚\033[0m')

            # API Changes don't let you list instance users.  Gotta try/except.
            try:
                userlist = getinstanceusers(u['location'].split(':')[0], u['location'].split(':')[1])
                for u in sorted(userlist['users'], key=lambda u: u['displayName'].lower()):
                    parse_user(u)
            except:
                pass

def get_user_blocks():
    print("Player moderations by you. (Blocked users)")
    targeturi = apiurl + '/auth/user/playermoderations/?' + apikey
    if args.debug:
        print(targeturi)
    blockees = requests.get(targeturi, headers=headers)
    blockees = json.loads(blockees.content.decode('utf-8'))

    for blockee in blockees:
        if blockee["type"] == 'mute':
            blockee["type"] = "\033[0;31m" + blockee["type"] + "\033[0m"
        elif blockee["type"] == 'block':
            blockee["type"] = "\033[1;31m" + blockee["type"] + "\033[0m"
        elif blockee["type"] == 'hideAvatar':
            blockee["type"] = "\033[1;33m" + blockee["type"] + "\033[0m"
        elif blockee["type"] == 'unmute':
            blockee["type"] = "\033[0;32m" + blockee["type"] + "\033[0m"
        elif blockee["type"] == 'showAvatar':
            blockee["type"] = "\033[1;34m" + blockee["type"] + "\033[0m"

        print("{0:<22} {1:<25} {2:<45} {3}".format(blockee["type"], blockee["targetDisplayName"], blockee["targetUserId"], blockee["created"]))

def get_user_blocked():
    print("Player moderations against you. (Blockers)")
    targeturi = apiurl + '/auth/user/playermoderated/?' + apikey
    if args.debug:
        print(targeturi)
    blockers = requests.get(targeturi, headers=headers)
    blockers = json.loads(blockers.content.decode('utf-8'))
    for blocker in blockers:
        if blocker['type'] not in ["showAvatar", "unmute"]:
            if blocker["type"] == 'mute':
                blocker["type"] = "\033[0;31m" + blocker["type"] + "\033[0m"
            elif blocker["type"] == 'block':
                blocker["type"] = "\033[1;31m" + blocker["type"] + "\033[0m"
            elif blocker["type"] == 'hideAvatar':
                blocker["type"] = "\033[1;33m" + blocker["type"] + "\033[0m"
            else:
                blocker["type"] = "\033[0;33m" + blocker["type"] + "\033[0m"

            print("{0:<22} {1:<25} {2:<45} {3}".format(blocker["type"], blocker["sourceDisplayName"], blocker["sourceUserId"], blocker["created"]))

## Print off raw json if the --raw argument is passed, but format it pretty.
def print_raw_json(rjson):
    formatted_json = json.dumps(rjson, sort_keys=True, indent=4)
    colorful_json = highlight(formatted_json, lexers.JsonLexer(), formatters.TerminalFormatter())
    print(colorful_json)

## Check for extra args that might need additional bits on the query string.
def check_extra_args(uri):
    if args.numlimit:
        if args.numlimit > 100:
            raise argparse.ArgumentTypeError("Maximum number of results is 100.")
        uri = uri + "&n=" + str(args.numlimit)
    if args.world_tag:
        uri = uri + "&tag=" + str(args.world_tag)
    return(uri)

#
def purge_friends():
    from datetime import datetime

    offset=0
    offlinefriends=[]
    while True:
        targeturi = 'https://api.vrchat.cloud/api/1/auth/user/friends/?n=100&offline=true&offset=' + str(offset) + '&' + apikey
        targeturi = check_extra_args(targeturi)

        rjson = requests.get(targeturi, headers=headers)
        rjson = json.loads(rjson.content.decode('utf-8'))

        if len(rjson) == 0:
            break

        offlinefriends += rjson
        offset += 100

    for friend in offlinefriends:
        targeturi = 'https://api.vrchat.cloud/api/1/users/' + friend['id'] + '/?' + apikey
        rjson = requests.get(targeturi, headers=headers)
        rjson = json.loads(rjson.content.decode('utf-8'))
        dt=datetime.strptime(rjson['last_login'], '%Y-%m-%dT%H:%M:%S.%fZ')
        dt=datetime.now() - dt

        if args.purgeabledays:
            pdays=int(args.purgeabledays)
        elif args.purgedays:
            pdays=int(args.purgedays)

        if dt.days > pdays or pdays == 0:
            print ("\033[1;30m{0:<5}\033[0m ".format(dt.days), end='')
            parse_user(friend)
            if args.purgedays:
                print("This will eventually ask if you want to purge the user.")


# Read User/Pass, base64 encode, save to or update config file.
def setup_user():
    # Doin' imports for these here since we won't need them usually.
    from getpass import getpass
    import base64
    print("""   This will ask for your VRChat username and password to generate
    an auth token to save to a config file.  How much do you trust me?""")

    vrcuser=input("VRChat User: ")
    vrcpass=getpass("VRChat Pass: ")
    vrcuser=bytes(vrcuser, encoding="UTF8")
    vrcpass=bytes(vrcpass, encoding="UTF8")
    vrchash=vrcuser + b':' + vrcpass
    vrchash = base64.b64encode(vrchash)
    vrchash = vrchash.decode("UTF8")

    print("""    -- Writing changes to config file. --
    You shouldn't need to do this again unless you change accounts.
    Config file is located at: {}""".format(config_file))
    try:
        config.set("credentials", "authkey", vrchash)
    except configparser.NoSectionError:
        config.add_section('credentials')
        config.set("credentials", "authkey", vrchash)

    with open(config_file, 'w+') as configfile:
      config.write(configfile)

# lets get to parsing them options, shall we?
if args.world_search:
    worldsearch(args.world_search)
elif args.worldid_search:
    worldidsearch(args.worldid_search)
elif args.user_search:
    usersearch(args.user_search)
elif args.userid_search:
    useridsearch(args.userid_search)
elif args.friends or args.pubfriends:
    listfriends()
elif args.user_blocks:
    get_user_blocks()
elif args.user_blocked:
    get_user_blocked()
elif args.purgedays or args.purgeabledays:
    purge_friends()
elif args.setup:
    setup_user()
else:
    parser.print_help()
