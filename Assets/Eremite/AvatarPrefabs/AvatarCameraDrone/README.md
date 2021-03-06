# Avatar Camera Drone
AKA: The ERP Killer

**NOTES**:
 * This *requires* FinalIK.  
  * I'll eventually remake one that works on Constraints.
 * I packaged the `.unitypackage` long after the prefabs were set up and haven't tested the package.  If it's not working, try cloning the whole repository and drag the `Eremite` folder into `Assets`

A drone that can be summoned and flown around at will using a series of joints.

In this example, there's a camera attached and a render texture outputting to a screen for flying around.  The possibilities are pretty much endless though:

* Attach a chair!  Fly your friends around!
* Replace the mesh with a ghost and some spooky sounds to creep people out!
* Make a UFO that buzzes around the map to commemorate the Area 51 raid!
* Other stuff probably!

**Setup Difficulty** : wew lad.  read all this thoroughly and good luck to you.

### Features:
* Relatively easy to control.  Super intuitive in Desktop, takes a little bit of getting used to in VR.
* No clipping with walls since there's no collider on it.
* Does not trigger respawns or other OnAvatarHit/OnEnterTrigger/etc events.
* Is not affected by post-processing layers.
* Can see MirrorReflection layer same as the VR users' camera.  Tweakable in the camera culling mask.
* Force ERPers into private worlds where they belong.

### Requirements:
1. **FinalIK** : Prevents drone from rotating in a circle around you when turning.
  * Still usable without FinalIK, especially in VR, if you avoid turning your body.
2. **RigidBodies + ConfigurableJoint + Fixed Joint** : Base Unity stuff.
3. **Animators**: A lot of animators and animations.

### Other Tech:
* **Emote Toggle System** ( _Kuro_ ) : Tore apart this prefab to figure out how to enable/disable on emote.
* **Twin-Drive Flying System** ( _*?*_ ): Referenced the config joint and made several modifications for the controller joint.

##### Setup:
There's a prefab for VR and for Desktop in the prefabs folder.  Select the one most appropriate for your setup.   The main difference between the two is that the desktop one has a few additional fixed joints on the render screen to lock it to your head.

**Desktop Setup**:
1. Drag the prefab into the scene. There are 3 things inside that need to be moved into your avatar. (It's all kept in one prefab to keep the references to each other to lower setup steps)
  * Drag the `Controller Joint` onto the head.  This will make the drone follow your head direction.
  * Drag the `DroneDisplay` into armature under Hips. (Can't be under head or it will get scaled down to 0,0,0 and be invisible)
  * Drag the `CameraDroneRig` into your root game object, alongside armature/body.
2. Move stuff around!  
  * The display screen should be in front of your viewball, far enough away where you can still see your menu preferably. Drag the whole game object, not just the screen.
  * `ControllerJoint` should be at `0,0,0` on the head.  Reset the position and rotation to all 0's.  Scale doens't really matter.
  * Move the `CameraDroneEnable` object in the `CameraDroneRig` to where you want the object to spawn in at and reset to. (Will go back to the `CameraDroneReset` position)
3. Make sure `CameraDroneReset` and `DisplayScreen` are pointed to a rigidbody on the head bone (or the `ControllerJoint` to save on rigidbodies)
4. Set up emotes and gestures.
   * See the `CameraDroneAvatarOverrides` override controller for reference.

Should be good to go.

**VR Setup**:
Pretty much the same as Desktop, but instead of fixed-jointing the display to the head, just put it wherever you want it to be (left wrist in demo scene).

Still need to set head as the target of `CameraDroneReset` rigidbody. There's a `Head-RespawnPOS` in the prefab that can be placed under the head. (Without this, the drone tends to spawn at 0,0,0)

Paths will need to be edited in the animations if it's placed elsewhere.

One caveat is that you may need to rotate the joint to get it to be angled comfortably in your hand.  

*However* this will break the rotation of the drone if you only rotate the joint.  Proper workflow for rotating the control joint is as follows:

1. Drag the `CameraDrone` object from deep in the `CameraDroneRig` heirarchy to be a child of the `ControlJoint`
2. Reset *position and rotation* of the `CameraDrone` so it's on top of the `ControlJoint`
3. Rotate the `ControlJoint` so it's comfortable.  I prefer it so that hand forward and thumb up are the default resting position; matches normal controller posture.
4. Move the `CameraDrone` back to where it was before under `CameraDroneReset` and reset the *position* only (not rotation).  It will look odd cocked to the side, but that's because you're in T-Pose.

**General Setup Info**:
The emotes are set up to work for both the desktop and VR version to keep total number of animations down.

Check paths in animations if things are acting weird or not enabling.

Speed can be adjusted by changing the value in the animation for the Gesture Override: `GO-DroneFwd`

If in doubt, check the demo scenes.  Those should be in working order unless I broke something getting it set up for GitHub push. `¯\(ツ)/¯`

### Usage:
1. Pop the `E-EnableDrone` emote to enable the drone or to reset it back to its spawn position if you get lost.
2. `Fist` gesture will move it forward unless you've changed the overrides.
3. Not fist will stop it.  
4. Pop `E-DisableDrone` emote to disable it.

### Problems!
* This does not sync.  Like... at all really.  Networked IK + latency + the way it's simulated means everyone sees the drone in wildly different places.
* For some reason it seems to break a little in Full Body.  It still works, but seems to immediately start flying off as if `Fist` is active.
* VRChat's combat system breaks pretty much anything that uses rigidbodies.  Probably won't work in those worlds.

### Possible improvements or tweaks:
Setting the camera depth higher will let you override your normal view entirely to get a real drone's eye view.

Toss a little screen-space shader around the camera to display world coordinates, etc for getting to places that are otherwise obscured. (assuming you know the position)

Toggleable night-vision shader for the drone for when it flies into dark areas. (spotlight would be a performance nightmare and obnoxious)
