# Movable Spawn Location
I've seen a few people wondering how to change the spawn location in a world so I whipped up a prefab for it.  There are probably simpler ways to do it, but this is reliable and doesn't spam the output log with dozens of trigger messages.

_More meant as a demo than a prefab you can just drop into place._

The spawn location is set in the [VRC_SceneDescriptor](https://docs.vrchat.com/docs/vrc_scenedescriptor) like so:

![](https://i.imgur.com/DX0XaR2.png)

The idea is that you set this to be something within the purview of an animator with various triggers on it to induce certain animation states that scooch the spawn location around the scene:

![](https://i.imgur.com/9FnopEC.png)

When you send a trigger to the animator via the [Animation Trigger](https://docs.vrchat.com/docs/animationtrigger) action, it will play a simple, non-looping animation that moves the spawn position to a new place and disables the VRC_Trigger on itself, making sure the triggers are enabled for the other objects.

![](https://i.imgur.com/zcaf7L5.png)

You could technically skip the bit with toggling the triggers, but you'll see massive spam in your vrchat output log, particularly for the avatar collision/trigger enter type.

---

There's a demo scene with 3 different types of triggers, but you can do whatever you want as long as you send a trigger to the animator with the proper naming/position, etc.

Demo:
 * **OnInteract**: Click the cube and it'll move spawn location nearby.
 * **OnEnterTrigger**: This is set to collide with PlayerLocal, so when you walk on it, it moves the spawn to you. Since it's a trigger, it doesn't collide with the player so it would be suitable for when people walk through a door or enter an area.
 * **OnAvatarHit**: Subtle difference from above; this one collides with players so they can't walk through it.  This would be suitable for bumping into a wall, or stepping onto a specific platform, etc.

 I added a sphere to the spawn location just as a way to visualize that it's moving.  It doesn't serve any purpose aside from that.
