# Nginx HLS Streaming to VRChat VRC_SyncStreamPlayer
Quick info dump on streaming video from a home computer, through a server running Nginx-rtmp-module, to VRChat's sync stream player.
Dockerized, Based on: https://docs.peer5.com/guides/setting-up-hls-live-streaming-server-using-nginx/

Streaming a file via FFMPEG:

```shell
#! /bin/bash
echo -e 'Stream will be available at: \033[1mhttp://your.domain:8080/hls/stream.m3u8\033[0m'
video="${1}"
stream="${2:-stream}"
ffmpeg -re -i "${video}" -vcodec libx264 -vprofile baseline -g 30 -acodec aac -strict -2 -f flv rtmp://1.2.3.4:1935/show/${stream}
```

Plug the `.m3u8` file into the VRC stream player to play it: `http://your.domain:8080/hls/stream.m3u8` (IP also works)
