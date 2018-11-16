# Pedestal Unlocks
Collect Items, place them on pedestals, door or something unlocks.  A tried and true game trope. There are several ways to do this.

The provided prefabs/demo scene should serve more as a reference for the concepts behind making this sort of unlock system than a ready-made thing you can drag/drop into your map, though that is indeed possible.

---
##### VRC_Destructible and AddDamage on a Game Object

This adds an empty game object with [VRC_Destructible](https://docs.vrchat.com/docs/vrc_destructiblestandard) on it with 3 Health.  When an object is placed a pedestal, it removes one HP from this object with [AddDamage](https://docs.vrchat.com/docs/adddamage).

The `OnDestructedTrigger` plays when it reaches 0 HP (all 3 objects placed) and calls a custom trigger to unlock the demo object.

**Positives**:
  * Doesn't need to be unlocked in any specific order.
  * Easy to add more pedestals.

**Negatives**:
  * Prone to breaking if you get the Broadcast type set wrong.  EG: If it's set to Always, then a message gets sent for each person in the room.  So, 3 people in the room would instantly unlock the target after one object was placed.

---
##### VRC_Trigger Unlock Sequence (Daisy Chain)

This one just has a trigger on each pedestal, but it is only enabled on the first one.  When the first is activated, it disables its own trigger and activates the trigger of the next pedestal in the chain.  There are multiple ways to do this as well, such as enabling/disabling colliders, turning game objects off and on, etc.

**Positives**:
 * Less likely to break and syncs well.
 * Still relatively easy to set up and expand on, but not as easy as the first option.

**Negatives**:
 * You have to unlock in a specific order.
 * Rubbing Object A on Pedestal B does nothing until it's unlocked.


---
##### Animator + OnEnterTrigger/OnExitTrigger
This one just has three trigger colliders on top of each pedestal.  When an object enters the trigger, it sets `Pedestal#` to True on the animator.  If it leaves the trigger, it sets `Pedestal#` to False.

Once all 3 are set to True, then it will enter an unlock state in the animator which sends a custom animation event to trigger a custom unlock trigger.

If one is removed after it's unlocked, then it will return to a locked state and wait for the item to be returned.

**Positives**:
  * Ability to lock/unlock by adding/removing objects.
  * More options for animating the unlock or placing items on the pedestal if you want to get creative.

**Negatives**:
  * Kindof a pain to set up if you're not familiar with animators.
  * It will spam your output log really bad if you use `OnEnterCollider` instead of `OnEnterTrigger`.

---

##### Notes:
All the pickups are in `Layer22` in Unity.  Pedestals that need to use collision triggers are in `Layer23`.  Not sure if this will show up properly if these layers aren't already set up in Unity for your project.

The pickups are set to delete themselves if they collide with `Layer23`.  The reason is obvious if you try a test build; it will remove the object you're holding and enable a display object on top of the pedestal.

To avoid having pickups be deleted by pedestals that are already triggered, or pedestals that aren't yet ready to be triggered, there are several `SetLayer` actions in the various `VRC_Triggers` to only set them to `Layer23` when ready to accept a cube, else set them to `Default` so they don't eat all the pickups.

**I have only tested in single-player test world** so there may be some sync problems.  If you find some, please let me know and/or fiddle with the Broadcast types a bit.
