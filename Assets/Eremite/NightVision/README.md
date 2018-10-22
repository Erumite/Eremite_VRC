# Night Vision Shader
This shader will let you see at very low light levels when you look through an object with the shader applied.  You can see in complete darkness with a very low-intensity light that is imperceptible to other users.

---

**VR Setup**: Easy Peasy.  Apply the shader to a material on the thing you want to look through.  Hold it in front of your face to be an owl.

---

**Desktop Setup**: This is kinda wierd.  You can't just add it to your head as VRChat will hide anything attached to the head bone.  You'll have to use some fixed-joint magic to get this to work.

1. Drag `night_vision.prefab` into your armature (alongside `Hips`)
  * You may need to scale the object to be an appropriate size.  It should be roughly the size of your head and cover your view ball.
  * Apply the `Nightvision` shader of your choice to `Material Slot 0`.
  * Apply the `Nightvision_Obscure` shader to `Material Slot 1`.  This makes the night vision shader invisible from outside the sphere.
2. Add a Fixed joint to the head.
  * No gravity/Non-Kinematic.
  * Lock all positions/rotations.
3. Set the head as the connected body on the fixed joint for the nightvision prefab.
4. Create an animation to enable the mesh renderer on the night vision object and optionally enable the spotlight.

**Caveats**:
* Fixed joints break in worlds with combat enabled.  This may make it unusable on those worlds.
* Moving quickly or going into crouch/prone mode may move your head outside the view ball.  Play with the positioning on the sphere if this is too big of a problem.
* There are occasionally some glitches in worlds with post-processing effects that can cause flashing/strobe effects.  If this may cause problems for you, you might want to avoid using this.

---
