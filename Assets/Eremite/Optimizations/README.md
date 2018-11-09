# Optimization
Ways of improving frames in worlds.  Mostly just a place to keep notes to myself and remind myself how I did stuff.

Added a `VRC_Scene_Descriptor` to the demo scene for quick building/testing in-game in a local test world.

---
#### Prefabs:
* **Mirror_LOD_Disable**: A mirror that disappears and is replaced by a reflective plane when you walk a certain distance from it.  Using LOD groups and requires a reflection probe for dummy mirror to reflect the room.
* **Mirror_Player_Triggered**: A mirror that shows the reflective plane above until a player enters a collider in front of it.  Disables itself when they exit the collider.  Required reflection probe for the dummy mirror.

---
## Links:

##### Lighting:
* [Baked Lighting](https://vrcat.club/threads/xiexes-lighting-tutorial-how-to-get-good-at-baked-lighting-101.2081/): Guide on VRCat forums that covers a ton of light-baking info, reflection probes, light probes, etc.
* [Light Probes](https://www.youtube.com/watch?v=ynqu-AgfoL4):  Bake lighting for non-static data into probes to avoid realtime lighting.
* [Reflection Probes](https://www.youtube.com/watch?v=t7jiayVKYfU): For reflective objects in scene. People with reflective avatars will love you.

##### Draw Calls:
* [Mesh Combine Wizard](https://forum.unity.com/threads/mesh-combine-wizard-free-unity-tool-source-code.444483/): ES Tools Menu -> Mesh Combine Wizard - It will take a parent object in the window
that pops up and will combine all the meshes that are children of that object, save them as a new mesh, disable the parent, then enable the new combined mesh.  Great draw-call reducer for
multi-mesh models/statics.  Caveats:  Can't do multi-material meshes, total meshes can't have more than 65536 vertices or things get really weird.
