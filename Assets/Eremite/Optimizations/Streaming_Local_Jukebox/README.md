# Streaming Local Jukebox
This is the music setup I used in [Fidget Balls](https://www.vrchat.net/launch?worldId=wrld_cd6a9712-1192-4b4c-b694-29590a920a13) ([DEV World](https://www.vrchat.net/launch?worldId=wrld_848408b0-eb4a-4969-87b9-39c27766b6ab)) to keep the file size down.  The world is 10MB (2MB for dev world after space optimizations), but there's roughly 1 GB of music available for streaming.  All songs are selected and played locally and unsynced.

The idea was to have a jukebox that you could interact with to pick your own background music.  It doesn't matter if it's synced or not, and everyone could be listening to different things depending on their taste.  No point in making visitors download a ton of music they may not even listen to, right?

This was only really possible by uploading the video files with the world (inflating the download size), or synced via the SyncVideoPlayer.  Neither of these had the behavior I wanted, and the sync player is very prone to breaking.
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
