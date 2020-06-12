# Nginx HLS Streaming to VRChat VRC_SyncStreamPlayer
Quick info dump on streaming video from a home computer, through a server running Nginx-rtmp-module, to VRChat's sync stream player.  

Dockerized, Based on:  
https://docs.peer5.com/guides/setting-up-hls-live-streaming-server-using-nginx/  
Also props to this guy for finding a clever way to add authentication to streaming:  
https://smartshitter.com/musings/2017/12/nginx-rtmp-streaming-with-simple-authentication/

---

### Streaming

1. Edit password in the `nginx.conf` file on the line below:
 ```
 if ( $arg_key = 'EremiteSucks' ) {
 ```
2. Build docker container (see the `rebuild.sh` file I added for testing).

3. Use the same password as the `key` query string argument when streaming a file via FFMPEG:

Little script you can pass a video/stream name to:
```shell
#! /bin/bash
video="${1}"
stream="${2:-stream}"
password="EremiteSucks"

echo -e "Stream will be available at:\033[1m http://your.domain:8080/hls/${stream}.m3u8 \033[0m"

ffmpeg -re -i "${video}" -vcodec libx264 -vprofile baseline -g 30 -acodec aac -strict -2 -f flv rtmp://1.2.3.4:1935/show/${stream}?key=${password}
```
You can also apparently stream with OBS or VLC; anything that can send to an RTMP stream, really.

---

### Playing

Plug the `.m3u8` file into the VRC stream player to play it: `http://your.domain:8080/hls/stream.m3u8` (IP also works)

Nginx conf could be edited to require a key to *view* the stream as well, but not really necessary unless you want.

---

Image Size:

```
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
eremite/nginxhls     latest              4989cf43c7ec        2 hours ago         18.8MB
```
