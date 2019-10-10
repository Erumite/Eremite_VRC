# Avatar Camera Drone
A drone that can be summoned and flown around at will using a series of joints.

In this example, there's a camera attached and a render texture outputting to a screen for flying around.  The possibilities are pretty much endless though:

* Attach a chair!  Fly your friends around!
* Replace the mesh with a ghost and some spooky sounds to creep people out!
* Other stuff probably!

### Requirements:
1. **FinalIK** : Prevents drone from rotating in a circle around you when turning.
2. **RigidBodies + ConfigurableJoint + Fixed Joint** : Base Unity stuff.
3. **Animators**: A lot of animators and animations.

### Other Tech:
* **Emote Toggle System** ( ___ ) : Tore apart this prefab to figure out how to make it enable/disable on emote.
* **Twin-Drive Flying System** ( ___ ): Referenced the config joint with several modifications for the controller joint.

##### Setup:
There's a prefab for VR and for Desktop in the prefabs folder.  Select the one most appropriate for your setup.   The main difference between the two is that the desktop one has a few additional fixed joints on the render screen to lock it to your head.

**Desktop Setup**:
1. Drag the prefab into the scene. There are 3 things inside that need to be moved into your avatar. (It's all kept in one prefab to keep the references to each other to lower setup steps)
  * Drag the `Controller Joint` onto the head.  This will make the drone follow your head direction.
  * Drag the `DroneDisplay` into armature under Hips. (Can't be under head or it will get scaled down to 0,0,0 and be invisible)
  * Drag the `CameraDroneRig` into your root game object or armature.  Not sure which one's better.  Probably armature?
2. Move stuff around!  
  * The display screen should be in front of your viewball, far enough away where you can still see your menu preferably. Drag the whole game object, not just the screen.
  * `ControllerJoint` should be at `0,0,0` on the head.  Reset the position and rotation to all 0's.  Scale doens't really matter.
  * Move the `CameraDroneEnable` object in the `CameraDroneRig` to where you want the object to spawn in at and reset to. (Will go back to the `CameraDroneReset` position)
 3. Set up emotes and gestures.
   * See the `CameraDroneAvatarOverrides` override controller for reference.

Should be good to go.

**VR Setup**:
Pretty much the same as Desktop, but instead of fixed-jointing the display to the head, just put it wherever you want it to be.  By default, it will go under the Left-Wrist bone.  Paths will need to be edited in the animations if it's placed elsewhere.

**General Setup Info**:
The emotes are set up to work for both the desktop and VR version to keep total number of animations down.

Check paths in animations if things are acting weird or not enabling.

### Usage:
1. Pop the `E-EnableDrone` emote to enable the drone or to reset it back to its spawn position if you get lost.
2. `Fist` gesture will move it forward unless you've changed the overrides.
3. Not fist will stop it.  
4. Pop `E-DisableDrone` emote to disable it.

### Problems!
* This does not sync.  Like... at all really.  Networked IK + latency + the way it's simulated means everyone sees the drone in wildly different places.
* For some reason it seems to break a little in Full Body.  It still works, but seems to immediately start flying off as if `Fist` is active.
