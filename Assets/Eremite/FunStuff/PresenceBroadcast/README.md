
# Presence Broadcast

This is a system for broadcasting a live performer from a stage in a "live" instance to a matching stage in many "child" instances, along with accompanying visuals and audio, while keeping all three in sync with each other.

All data is contained in a single 720p (1280x720) video stream with screen space allotted by fidelity requirements.

Developed for bringing live performance broadcast and replay to [VirtualBass](https://twitter.com/virtualbass)    
A special thanks to the devs and artists working on that project; it's been a blast.

---

#### How does it work?

This [Demo Vid](https://cdn.discordapp.com/attachments/695514157885292604/714084443970601011/2020-05-24.06-54.15.mp4) shows an example of how it works. (Size/Spacing out of date):
* Left side is the "live" side.
	* The video is direct via a video player component (`VRC_SyncVideoPlayer`),
	* The performer is captured on a render texture by a perspective camera pointed at the stage.
* Center shows how the output is combined.
	* Video keeps same aspect ratio and resolution.
	* Performer is flipped 90° clockwise for best usage of space.
	* Green area is unused, but can be expanded into for more synced effects.
	* A short-range orthographic camera captures this to a 1280x720 render texture.
* Right side is a reconstruction of the live stage using only the output of the center.
	* Stream player requires a custom mesh with UVs matching the spec reference image.
	* Video / Performer are two "planes" with UVs moved to the appropriate portion of texture.
	*  Video is captured in near original quality with no scaling required.
	*  Performer is rendered with a black chroma key shader with a hologram overlay to mask resolution loss.

---

#### Notes:
There are a few iterations of a chroma key shader, including a "green screen" shader that have been deprecated in favor of a black chroma key shader.  It turns out that it's really hard to chroma key out a color when resolution loss and color blending around edges is happening.  They are fun though, so I left them in.

Unfortunately there's no way to broadcast the alpha channel over a live stream, which necessitates a chroma key shader to remove the background.

Avatars that have pure black on them will have those portions invisible in the child instances.

The bottom left section of the stream output is unused at the moment but will be used eventually for syncing effects (fireballs, etc), stream text (Now playing, subscribers, etc), and whatever else we can stuff into it.

---

## Setup:

#### Requirements:

 * OBS (Or other streaming software)
 * Twitch account set up for live streaming. (Or other streaming service)
 * Someone with a powerful computer to stream.  The stream quality is only as good as they can encode it and the stream FPS is only as high as their VRChat client can output.
 * A decent knowledge of Unity and VRChat SDK 2.0

#### Adding the prefab:
1. Drag the prefab into your scene.
  * The prefab can be unpacked at this point if you prefer.
  * All the objects are kept within a single prefab for maintaining references.
2. Move the `StageScreen` to where you want the visuals.
  * Scale the `StageScreen` object where possible to keep aspect ratios on child screens the right size.
  * If you scale a screen for the `Screen-LIVE` or `Screen-CHILD` objects, make sure that they match up between the two versions for maximum recreation accuracy.
3. Move `VideoControls` to somewhere accessible.
  * The `Menu-LIVE` object can be moved somewhere hidden or enabled by a password or keypad for best security.
  * The `Menu-CHILD` object should be somewhat prominent as it has the Resync button on it for fixing a stalled stream in child instances.
4. Ensure that there's an `EventSystem` in the scene somewhere.
  * Uncheck `[ ] Send Navigation Events`
  * Otherwise, default settings are fine.
5. Move the `StreamerBooth` object away and into a separate room.
  * You want the streamer to have as much occluded as possible.  They will be viewing the event through a camera, so avoiding rendering everything twice saves framerate.
  * You want them far enough away that they can hear the music/audio, but not the voices of others in the instance.
  * The `StreamAggregation` object should not be in a wall or other object when enabled.
6. Set up toggle triggers to switch between LIVE and CHILD instances.
  * It should be CHILD by default.
  * Method of switching to live is up to you.  I'd suggest a password or keypad to hide it from child instance users.
  * The `InstanceSwitchTriggers` object has a `SwitchToChild` and `SwitchToLive` custom trigger that can be referenced by a `VRC_Trigger` `ActivateCustomTrigger` action.

---

#### Using the system:

When you load the world, the child stage should be on by default with the `VRC_SyncVideoStream` component set to the stream that will handle transferring the instance data.

After converting an instance to a **live** instance (ideally with a password, etc), the stream player is replaced by a video player with a playlist of the sets and the performer recreation plane is hidden.

`!!!` Make sure the `Master` of the instance has very good and stable internet and is not prone to crashing, etc.  VR Chat's video players hate it when ownership is transferred and can sometimes break mid-video.

Make sure your streamer is in place and streaming at least 5 minutes before the event starts.  This gives people in child instances time to pick up the stream so they don't miss the start of the event.  A "starting soon" graphic can be created using the [PresenceBroadcastSpec.png](Assets/Eremite/FunStuff/PresenceBroadcast/PresenceBroadcastSpec.png) file as a reference.

Once it's time to start the show, hit play on your playlist and let your artists do their thing on the stage!

---

#### Disaster Recovery!

Stuff that can go wrong in the live instance:

* **Video server goes down!**:  Video halts.
* **Video server bandwidth overloaded!**: Video will halt or stutter.
* **Master disconnects or crashes**: Chance to break video, staff may lose ownership.
* **Master has to go for unexpected reasons**: Risks staff losing ownership.

Ways to mitigate these problems:


* **Staff loses ownership of video player** : Add a password that calls the `TakeOwner` custom trigger on the `PresenceBroadcast/VideoControls/Canvas/TakeOwnershipButton` object.  This takes ownership of the player, but risks breaking the player.  Best used at the beginning of a new set.
* **Master needs to leave** : The master can click the `Pass Master` button on the menu, then confirm to create a button that anyone in the instance can click to take ownership of the player.  Risks breaking the player and is best used at the start of a new set.
* **Video server bandwith overload** : Kick some people out of the instance, maybe? Fewer people in the live instance should require less bandwidth.  
  * In the future, do your math in advance based on set size and max upstream to see how many people you can let into the live instance.
  * Alternately, go with a [load balanced setup](https://en.wikipedia.org/wiki/Load_balancing_(computing)) or a cloud provider like [Google Cloud Storage](https://cloud.google.com/storage) or [Amazon S3](https://aws.amazon.com/s3/).
* **The video player breaks/stalls**:
  1. You can try the play/pause button.  Ideally it should pick up where it left off.
  2. If not, click the `Oh %#&@!` toggle to show extra controls.
  3. You can click the `Previous` button to re-start the set, then use the seek buttons to find roughly the right area.  You can seek forward/backward by 300, 60 or 30 seconds to recover as quickly as possible.
  4. If all else fails, you can enter the URL of a file on a backup server (you have backups, right?) and use the seek buttons to get to the appropriate time.  This should be a last resort as it clears the playlist and all URLs need inputting manually after a set ends.

Still broken? Put those critical thinking skills to work.  If all else fails, blame it on the VRC devs; They should be used to it by now. :^)


Stuff that can go wrong in the child instance:

* **Player stalls/stops working** : It's a livestream. Just click the resync button or reload the world.

---

#### Making modifications.

If you want to add extra screens or other embellishments that reference the screen contents, use the included spec reference image and keep in mind that you need live and child versions of all screens.

![Specsheet](Assets/Eremite/FunStuff/PresenceBroadcast/PresenceBroadcastSpec.png)
