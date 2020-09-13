#! /bin/bash

## Used for prepping a video for the Re-LIVE system.  Needs:
##  * The original audio/visuals file in 16:9 Aspect
##  * A VOD or video of the Presence Broadcast streamer output.
##
## This preserves the integrity of the original visuals and audio
##   so they don't suffer from being encoded too many times.
##
##  CPU go BRRRRRRRRRRRRRRRR

# Change to anything but 'true' to disable.
#  If 'true', only encode the first ${debugtime} seconds for testing.
debug='true'
debugtime='5'

function showhelp() {
  echo -e '
Usage: relivevid <visuals.mp4> (relive.mp4) (output.mp4)
  <> = Required
  () = Optional

If optional args aren not provided, it will use these:
   Relive Vid:  ./relive/$1
   Output Vid:  ./combined/$1

Visuals should follow Re-LIVE spec.  Video should be:
  * Ideally 900x506, but any 16:9 resolution should scale fine.

Relive Vid should follow Re-LIVE spec:
  * Video: 1280x720
  * Camera Portion: 380x720 Resolution, far right side
  '
}

function relivevid() {
  [[ -z ${1} ]] && showhelp || visuals="${1}"
  [[ -n ${2} ]] && relive="${2}" || relive="relive/${visuals}"
  [[ -n ${3} ]] && output="${3}" || output="combined/${visuals}"

  [[ $debug == "true" ]] && testtime="-t ${debugtime}"  || testtime=''

  # Return if the input is derped up.
  if [[ -z $visuals || -z $relive || -z $output ]]; then
    showhelp
    return 1
  fi

  ffmpeg ${testtime} -i ${visuals} ${testtime} -i ${relive} -filter_complex \
    "[0:v]scale=900:506,pad=1280:720:0:0[v]; \
     [v]split[m][a]; \
     [a]geq='if(gt(lum(X,Y),16),255,0)',hue=s=0[al]; \
     [m][al]alphamerge[vis]; \
     [1:v]scale=1280:720[c]; \
     [c]crop=380:720:900:0,scale=380:-1,pad=1280:720:900:0,yadif,format=rgb24[c2]; \
     [c2]lutrgb=r='if(lte(val,20),0,val)':g='if(lte(val,20),0,val)':b='if(lte(val,20),3,val)'[cam]; \
     [cam][vis]overlay=0:0[vid] \
    " \
    -map [vid] \
    -map 0:a:0 \
    -c:v h264 -preset veryslow -movflags +faststart \
    -c:a aac -strict -2 ${output}

  # Cleanup variables.
  unset visuals relive output testtime STAHP
}

# Unset when sourcing.
unset visuals relive output testtime STAHP
