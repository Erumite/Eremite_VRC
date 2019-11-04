# Streaming Local Jukebox
This is the music setup I used in [Fidget Balls](https://www.vrchat.net/launch?worldId=wrld_cd6a9712-1192-4b4c-b694-29590a920a13) ([DEV World](https://www.vrchat.net/launch?worldId=wrld_848408b0-eb4a-4969-87b9-39c27766b6ab)) to keep the file size down.  The world is 10MB (2MB for dev world after space optimizations), but there's roughly 1 GB of music available for streaming.  All songs are selected and played locally and unsynced.

The idea was to have a jukebox that you could interact with to pick your own background music.  It doesn't matter if it's synced or not, and everyone could be listening to different things depending on their taste.  No point in making visitors download a ton of music they may not even listen to, right?

This was only really possible by uploading the video files with the world (inflating the download size), or synced via the SyncVideoPlayer.  Neither of these had the behavior I wanted, and the sync player is very prone to breaking.

---

##### Video Hosting
One downside is that you can't rely on YouTube to host the files for free.  You will need to create an MP4 file that can be uploaded to a hosting site.  This can be a bit of a convoluted process, but this has been my work flow:

1. Find music on YouTube that I want to play.
2. Download the contents as an MP3 using a site like https://ytmp3.cc/
  * Lazy Version: Download it as MP4 instead and skip to the bit about uploading the file. This will result in a much larger file size though and you may have problems finding a place to put it.
3. Unity requires an MP4 file, not MP3.  We need to do some magic.
  * Find a background image and resize it. The smaller the image, the smaller the end file size of the mp4. I usually do 160x120 (640x480 divided by 4).
    * *You could do 2x2 if you don't care about having an image; do **not** do 1x1 as Unity can't play a video with an odd number of pixels in the length or width.*
  * Convert the mp3 file to mp4 with the image as a background.  Good luck with this.  There are several tools out there, but I personally do it with [ffmpeg](https://www.ffmpeg.org/) via the command line:
    * `ffmpeg -loop 1 -i image.png -i music.mp3 -c:a aac -ab 192k -c:v h264 -strict -2 -pix_fmt yuv420p -shortest output.mp4`
    * Adjust the `192k` to no higher than the encoding of the mp3 file or else you're just wasting file size.  You can set it lower to reduce file size more.
    * Audio/Video codecs are based on the video player's [recommended encoding settings](https://docs.unity3d.com/ScriptReference/Video.VideoPlayer.html) and are very performant without the lag and frame drops typically seen from YouTube videos starting/stopping with the `VRC_SyncVideoPlayer` component.
  * Upload the file somewhere.
    * [https://db.tt/NOI1fUGG](https://www.dropbox.com/) : Some bandwidth restrictions. No file size limit. (Referral URL, lol.)
    * [MixTape.moe](https://mixtape.moe/) : 100MB limit; no bandwidth restrictions.  Files are frequently removed.
    * [AmazonDrive](https://www.amazon.com/clouddrive) : No file limit as far as I know.  Haven't actually used this one.
    * [Handbeezy](http://handbeezy.com/tmY72Olke/) : 100MB limit.  Had good luck so far with videos not being removed.
    * Self Hosted.  Got a server? Stick it on there. If you're worried about bandwidth, CloudFlare will cache files [up to 512MB](https://support.cloudflare.com/hc/en-us/articles/200394750-What-s-the-maximum-file-size-Cloudflare-will-cache-).
    * Others. You can figure it out, you're a smart cookie.
  * Once you have a link to the MP4, try sticking it into a video player in Unity, hit play and see if it starts playing.  If it does, you're good.  If not, you may need to make sure you have a download URL, not a preview URL.
  * Optional: Make a [TinyURL](https://tiny.cc/) account so you can have custom links that can be edited later.  You can set up a TinyURL link to redirect to the video file and the VideoPlayer will respect the redirect.  If something happens to the video later, you can re-upload and edit the redirect to point to the new address without having to upload the world again.

**Holy mackerel!**  Typing all this out made me realize how much of a mess this method is.  I suppose the real step 1 is deciding if you want to go through all this hassle just to keep the world filesize down.  If you're an optimization nerd, the answer is probably yes.

---

##### Demo
See the demo scene for an example:
1. Click the blue button to show music choices.
2. Select a song you want to play (demo scene just has two sample videos).
3. Enjoy.  Click red button to stop music or to reset to select another song/video.
---
##### Expanding
The sample prefab has 6 music choices, but this can be expanded relatively easily:

1. Duplicate a video player under the `Music_Sources` game object and input a new URL into it.
2. Dupliate a song selection button under the `Music Controls` game object.
3. Drag the duplicated video player (eg: `7-SONG7`) into the newly created button's `VRC_Trigger`.  It should be in the `SetGameObjectActive` -> `True` one.
4. Edit your button text and material to something appropriate.
5. Add the duplicated `7-SONG7` object to the `VRC_Trigger` for the `Music_Off` button. There should be a `SetGameObjectActive` -> `False` action in there that contains all the music players.

I chose to do it this way since it seems to be the easiest way to get the functionality I wanted, but make it relatively easy to expand the selection.

---

##### Customization
The demo I added is pretty bland; plain colors for the on/off buttons and my demo material/logo thingy for the music choices and loading screen.

You can change the material on the quads under `Music_Sources` to something else as a "loading screen" while the video plays.

However, make sure that the Albedo is set to black, and the texture is added to Emissive, set to white.

![](https://i.imgur.com/x4iRjQE.png)

Or if you decide you really want Albedo instead, you'll have to change the video player component's `Material Property` setting to `_MainTex` for the material override.

I'd also recommend adding a small icon to each of the music choices, and possible icons or decorative backgrounds to the Play/Stop buttons.  Go wild.

---

##### Preview
**This is how it looks in FidgetBalls.**:

1. Click to show choices.
![](https://i.imgur.com/hFLk5tm.png)
2. Select a song.
![](https://i.imgur.com/mtrJhKU.png)
3. It starts playing!  Red button to reset.
![](https://i.imgur.com/EdEPeuL.png)

##### Update:
Nov 3 2019 - Optimized a bit by having all video players use the same audio source/screen to make it easier to edit.
