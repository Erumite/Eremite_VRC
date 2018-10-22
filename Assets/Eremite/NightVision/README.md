# Night Vision Shader
This shader will let you see at very low light levels when you look through an object with the shader applied.  You can see in complete darkness with a very low-intensity light that is imperceptible to other users.

---

**VR Setup**: Easy Peasy.  Apply the shader to a material on the thing you want to look through.  Hold it in front of your face to be an owl.

---

**Desktop Setup**: This is kinda wierd.  You can't just add it to your head as VRChat will hide anything attached to the head bone.  You'll have to use some fixed-joint magic to get this to work.

1. Drag `night_vision.prefab` into your armature (alongside `Hips`)
  * You may need to scale the object to be an appropriate size.  It should be roughly the size of your head and cover your view ball.
  * Apply the `Nightvision` shader of your choice to `Material Slot 0`.
  * Apply the `Nightvision_Obscure` shader to `Material Slot 1`.  This makes the night vision shader invisible from outside.
2. Add a Fixed joint to the head.
  * No gravity/Non-Kinematic.
  * Lock all positions/rotations.
3. Set the head as the connected body on the fixed joint for the nightvision prefab.
4. Create an animation to enable the mesh renderer on the night vision object and optionally enable the spotlight.

**Caveats**:
* Fixed joints break in worlds with combat enabled.  This may make it unusable on those worlds.
* Since your character's head does not perfectly match the view ball's motion, moving quickly or going into crouch/prone mode may move your head outside the view ball. Possible fixes:
  * Play with the positioning on the sphere.
  * Replace your running/walking animation with a motion that causes less head motion.
* There are occasionally some glitches in worlds with certain post-processing effects that can cause flashing/strobe effects.  If this may cause problems for you, you might want to avoid using this.

---

**Nerd Stuff**:
This is taking the RGB value of each pixel and calculating the proportion of each color:
* Red = Red/(Red+Green+Blue)
* Green = Green/(Red+Green+Blue)
* Blue = Blue/(Red+Green+Blue)

These are re-combined into an RGBA vector4 and by itself results in a working night vision, but the detail of shadows are lost. To try to keep the shadows, we find the max of the RGB values to set as a baseline for how bright the object should be.

```
let:
  x = maximum of RGB values
  s = sensitivity value

brightness modifier = x/(x+s)
```
This creates a value that grows very quickly at low values, but slows down as it approaches one. [WolframAlpha](https://www.wolframalpha.com/input/?i=graph+x%2F%28x%2B.1%29+from+0+to+1)

We can then multiply this value by the RGBA vector 4 to have varying intensities of objects in the scene. :3

The obscuring shader is super simple and just grabs whatever's behind it and passes it forward, doing effectively nothing.  However, since it's render queue is directly before the night vision shader, you don't see the night vision shader from outside the sphere.

The sphere for desktop users is just a normal sphere created in blender, but with its faces duplicated, then shrunk a bit and its normals flipped.
