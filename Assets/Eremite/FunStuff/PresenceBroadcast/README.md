# Presence Broadcast

**Under Construction**  
POC for broadcasting a live performer on stage with accompanying visuals from a parent/live instance to many child instances while keeping audio, visuals, and performer motions in sync.

All data is contained in a single 720p (1280x720) video stream with screen space allotted by fidelity requirements.

Tentative method of bringing live performances to [VirtualBass](https://twitter.com/virtualbass).

---

[Demo Vid](https://cdn.discordapp.com/attachments/695514157885292604/714084443970601011/2020-05-24.06-54.15.mp4) :
* Left side is the "live" side. The video is direct, the performer is captured by a camera.
* Center is the resulting texture that is broadcast to Twitch, etc.
* Right is reconstructed using only the middle texture and a greenscreen/blackscreen shader to render only the performer on stage.

---

The greenscreen shader has since been deprecated in favor of a "blackscreen" shader which seems to look better.
Unfortunately there's no way to broadcast the alpha channel over a live stream, which necessitates a chroma key shader to remove the background.
As such, avatars that have pure black on them will likely have those portions invisible.

Bottom left section is unused at the moment but will be used eventually for syncing effects (fireballs, etc), and stream text (Now playing, subscribers, etc).

---

Prefab documentation and setup coming once things are more finalized.
