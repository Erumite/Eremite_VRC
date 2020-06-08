# Presence Broadcast

**Under Construction**  
The idea is to have a live stage with a performer on it, which is then broadcast to child instances via a single video stream to keep all audio, video and performer interactions in sync.

There are more realistic ways of doing this, but since all data must be contained in a single 720p video stream, the more complexity you add and the more textures are required, the lower resolution everything gets.

Tentative method of bringing live performances to [VirtualBass](https://twitter.com/virtualbass).

[Demo Vid](https://cdn.discordapp.com/attachments/695514157885292604/714084443970601011/2020-05-24.06-54.15.mp4) :
* Left side is the "live" side. The video is direct, the performer is captured by a camera.
* Center is the resulting texture that is broadcast to Twitch, etc.
* Right is reconstructed using only the middle texture and a greenscreen/blackscreen shader to render only the performer on stage.

The greenscreen shader has since been deprecated in favor of a "blackscreen" shader which seems to look better.  Unfortunately there's no way to broadcast the alpha channel over a live stream, which necessitates a chroma key shader to remove the background.

Green section in bottom-left can be used for whatever; (EG: "Now Playing" scroll added by OBS, or "New Subscribers" scroll, etc.)
