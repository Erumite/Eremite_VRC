# Night Vision Shader
This shader will let you see at very low light levels when you look through an object with the shader applied.  You can see in complete darkness with a very low-intensity light that is imperceptible to other users.

---

**VR Setup**: Easy Peasy.  Apply the shader to a material on the thing you want to look through.  Hold it in front of your face to be an owl.

---

**Desktop Setup**: This is kinda wierd.  You can't just add it to your head as VRChat will hide anything attached to the head bone.  You'll have to use some fixed-joint magic to get this to work.

1. Drag `night_vision.prefab` into your armature (alongside `Hips`)
  1. Drag the `night_vision` prefab into the scene.
  2. Set the Y and Z values to the same as your ViewBall so they're at roughly the same position.
     * Can be slightly forward or adjusted up/down later if testing proves it's slipping out of view.
  3. Scale the mesh to be roughly the same size as your head.
     * May need to temporarily apply the Default material or enable selection outline if it's hard to see.
  4. Once it's in position and sized properly, move the `night_vision` object into your armature (alongside `Hips`)
    * Apply the `Nightvision` material if it's not already.
  5. Add a rigidbody to your head (or possibly child object of head).
    * No Gravity
    * Non-Kinematic
    * Lock all positions/rotations.
  6. Select `night_vision` object and drag the `head` in as the `Connected Body` for the `fixed joint`
  7. Create an animation to enable the mesh renderer on the night vision object and optionally enable the spotlight.

**Caveats**:
* Fixed joints break in worlds with combat enabled.  This may make it unusable on those worlds.
* Since your character's head does not perfectly match the view ball's motion, moving quickly or going into crouch/prone mode may move your head outside the view ball. Possible fixes:
  * Play with the positioning on the sphere.
  * Replace your running/walking animation with a motion that causes less head motion.
* There are occasionally some glitches in worlds with certain post-processing effects that can cause flashing/strobe effects.  If this may cause problems for you, you might want to avoid using this.
  * Amplify rewrite may have fixed this by clamping emission from 0-1. (Thanks, Chdata)

---

**Preview**: Before and after demos:
![off](https://i.imgur.com/DOkOY2W.png)
![on](https://i.imgur.com/sJ0WmT7.png)

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

For back faces, this is multiplied by 0 using the `Face` node and the screen color is passed as emission.

Logic preview.  Subject to change:

![nodes](https://i.imgur.com/bnrNRcJ.png)
