# Respawning or Resetting an Object
I've seen several people asking about respawning an object. There are several options for doing this that are suited to different scenarios.

In the demo scene there are some samples:

* **Normal Pickup** (capsule) : This is a normal pickup with nothing fancy added.  However, if it falls out of the map, it will respawn because of a setting on the `VRC_SceneDescriptor`.

![](https://i.imgur.com/qkaaFQH.png)
* **Reset On Drop-Simple** (sphere): This uses the `OnDrop` event and the `TeleportTo` action that is added by the ObjectSync script to reset the object to its original position after a delay.  The problem with this is that it can't be canceled by picking the object up again, so it will teleport once the timer is up, even if someone is holding it.  However, it will snap back to their hand afterward; this can be kindof jarring though.

![](https://i.imgur.com/aJDbOMu.png)

* **Reset On Collision with something** (cube): This will reset when it touches the ground, using the `OnEnterCollider` trigger with `Environment` set as the collision layer.  The plane has had its layer set to `Environment` manually instead of `Default`.  Again, no option to pick it up again, and if it falls on something that's not the target layer (a table or whatever), then it will not reset.

![](https://i.imgur.com/JDrdNAx.png)

* **Reset on Drop - Animator** (cylinder):  This one is a bit complicated to explain, but you can take a look at the animator and animations. When dropped, it will float for 5 seconds (gravity off), fall to the ground (gravity on), then after 5 seconds, will respawn to its original position.  If picked up during this 10 second period, it will cancel the respawn sequence.
  * Respawn time can be adjusted by either editing the corresponding animations to be longer, or setting the Speed in the animator state to a fraction. (EG: .5 speed will make it take 10 seconds instead of 5)
  * Multiple animations aren't really required, I just added an extra to show how versatile this method can be.
  * Final animation (`drop_object_reset`) is using an `Animation Event` -> `ExecuteCustomTrigger` (see the little tab on the top of the animation window).  It's not empty. :3

---

Hopefully these will be helpful. :)
