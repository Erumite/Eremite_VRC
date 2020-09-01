# ffmpeg notes for handling videos for streaming to PresenceBroadcast

###  Visuals/Audio in one file.
```sh
ffmpeg -i "${file}" -vf scale=900:-2 -c:v h264 -preset veryslow -movflags +faststart -c:a aac -ab 320k -strict -2 "encoded/${file}"
```

### Audio file + Looped Visuals File
Used to take a full audio set (30m) and loop a shorter visual behind it for the duration of the set.

```sh
audio=test.wav
visuals=test.mp4

length=$(ffprobe -i "${audio}" -show_entries format=duration -v quiet -of csv="p=0" -sexagesimal | cut -d. -f1|sed 's/^[0:]*//g');echo "${length}"

ffmpeg -t ${length} -stream_loop -1 -i "${visuals}" -i "${audio}" -map 0:v:0 -map 1:a:0 -vf scale=900:-2 -c:v h264 -preset veryslow -movflags +faststart -c:a aac -ab 320k -strict -2 "encoded/${visuals##*/}"
```

### Change FPS
Only necessary if the FPS is higher than 60 or if the stream will be in 30FPS.  Keeps filesize to a minimum.

```sh
ffmpeg -i "${file}" -vf "fps=fps=30,scale=720:-2" -c:v h264 -preset veryslow -movflags +faststart -c:a aac -ab 320k -strict -2 "encoded/${file}"
```

### reducing file size more:  ( +/- 6 = roughly +/- half bitrate)
Only really useful if the file size is too big for the streaming server to handle reliably.  I try to shoot for < 1GB per set.
```sh
# default = 23
ffmpeg ... -c:v h264 -crf 29 -preset veryslow ...
```

###  Summarize file size/length/bitrate & print links.
For printing off links/summary of files for checking over and providing to whoever's setting up the player.

```sh
function vbsummary() {
  baselink="https://domain.com/video/path"
  { echo "Size@Length@AudioBR@SampleRate@VideoFPS@Link"
  for i in *.mp4 ; do
    size=$(du -sh "${i}" | awk '{print $1}')
    length=$(ffprobe -i "${i}" -show_entries format=duration -v quiet -of csv="p=0" -sexagesimal | cut -d. -f1|sed 's/^[0:]*//g')
    bitrate=$(ffmpeg -i "${i}" 2>&1 | grep 'Stream.*Audio' | egrep -o '[0-9]* kb/s')
    fps=$(ffmpeg -i "${i}" 2>&1 | grep 'Stream.*Video'|grep -oP '[0-9.]*(?= fps, )')
    hz=$(ffmpeg -i "${i}" 2>&1 | grep 'Stream.*Audio' | grep -oP '[0-9]*(?= Hz, )')
    link="${baselink}/${i}"
    echo "${size}@${length}@${bitrate}@${hz}@${fps}@${link}"
  done ; } |column -t -s@
}
```
