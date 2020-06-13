#! /bin/bash

# Sample settings.  Override with ~/.nginxhls file.
serverIP='1.3.3.4'
scaling="-vf scale='min(1280,iw)':-2" # Scale down to 720p if higher res.
video="${1}"
stream="${2:-stream}"
streamKey="EremiteSucks"

# If the conf file below exists, source it. Used to override the sample settings above.
[[ -f ~/.nginxhls ]] && source ~/.nginxhls

echo -e "Stream will be available at: \033[1mhttp://${serverIP}:8080/hls/${stream}.m3u8\033[0m"

ffmpeg -re -i "${video}" ${scaling} -map 0 -vcodec libx264 -vprofile baseline -g 30 -acodec aac -strict -2 -f flv rtmp://${serverIP}:1935/show/${stream}?key=${streamKey}

# THe above breaks with ASS subtitles.  Weebs might need something like this?  Still working on it:
#ffmpeg -re -i "${video}" ${scaling}  -vf "subtitles=${video},format=yuv420p" -sn -vcodec libx264 -vprofile baseline -g 30 -acodec aac -strict -2 -c:s mov_text -f flv rtmp://${serverIP}:1935/show/${stream}?key=${streamKey}
