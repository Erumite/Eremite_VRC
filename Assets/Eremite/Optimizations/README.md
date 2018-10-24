# Optimization
Ways of improving frames in worlds.  Mostly just a place to keep notes to myself and remind myself how I did stuff.

Added a `VRC_Scene_Descriptor` to the demo scene for quick building/testing in-game in a local test world.

---
#### Prefabs:
* **Mirror_LOD_Disable**: A mirror that disappears and is replaced by a reflective plane when you walk a certain distance from it.  Using LOD groups and requires a reflection probe for dummy mirror to reflect the room.
* **Mirror_Player_Triggered**: A mirror that shows the reflective plane above until a player enters a collider in front of it.  Disables itself when they exit the collider.  Required reflection probe for the dummy mirror.

---
#### Links:
* [Light Probes](https://www.youtube.com/watch?v=ynqu-AgfoL4):  Bake lighting for non-static data into probes to avoid realtime lighting.
* [Reflection Probes](https://www.youtube.com/watch?v=t7jiayVKYfU): For reflective objects in scene. People with reflective avatars will love you.
