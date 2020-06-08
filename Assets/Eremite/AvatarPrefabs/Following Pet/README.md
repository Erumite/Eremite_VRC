## Super Simplified Pet/Minion System
**Have a pet set at a specified location on your avatar to have it follow you relatively fluidly.**

Achieves the effect with one dynamic bone script and two transforms.  Very low performance cost.

Fun fact: "Bones" in unity are pretty much just empty game objects as far as the dynamic bones script, so with some creative placement of the bones and some fine-tuning of the settings, we can get them to be a pretty passable minion system for cheap.

This is probably best for something that flies, like a little drone or something. (I was using a butterfly.)

Animations can also be applied to the following object to give it more natural movement.  Birds/butterflies flapping/fluttering motions, drones spinning and bobbing, etc.

#### Setup:
1. Drag the prefab into the root of your avatar. (Not in the armature, etc).
2. Move the "bones" into the proper places:
  * following_minion should be roughly at the same location as the head bone.
  * bone_1 should be by your feet and slightly behind you.
  * cubey-boi_minion should be where you want it to default to and slightly back from bone_1
3. Rename game objects to whatever you want.  My naming convention is silly.
4. Remove the mesh_renderer and mesh_filter from bone_1.  It's there for visualizing how it moves when setting up.
5. Press play and make sure it moves how you want.  Demo values in dynamic bones may not give the movement you want.

NOTE: When copying from my testing avatar to the demo scene, I wasn't able to move the game objects while the dynamic_bone script was enabled.  Also it would snap back to its original position if I re-enabled the script.  If you have this problem, delete the dynamic bone script from `following_minion` after adding the prefab, move things into position, then `copy`/`paste component as new` from the prefab to the `following_minion` game object.

![](https://i.imgur.com/QZeSaHE.png)

---

**Component explanations:**
* **following_minion**: This serves as the root of the dynamic bone script.
* **bone_1** : Simply a mid-bone. Added a mesh renderer to the demo scene to visualize how it's working.
* **cubey-boi minion** : Sample minion.  This should be replaced with whatever you want to follow you.
* **dummy_body** and **dummy_armature** : If the minion is rigged, you will need to add their skinned mesh renderer and armature to the exclusions of the following minion dynamic bone script.
