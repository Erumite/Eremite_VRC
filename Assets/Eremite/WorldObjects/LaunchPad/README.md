# Launch Pads
Just a fun unity trick that launches your player when you step off of the launch pad's collider.  Works with SDK2 also.

This bug got introduced in the 2017 version and persists in 2018.  It may be fixed in future versions though.

The bug manifests if you have:
* A parent object with a rigidbody.
* A scaled-down child object with a collider.

That's it.  I just added a rigidbody to a game object scaled up, then scaled down a child mesh and added a collider.  Super simple and fun.

Demo Vid: https://imgur.com/5aV25ka

Setup:
  Drag `LaunchPad.prefab` into the scene and position it.  You're done.

I also added some wands to spawn some so you can put them wherever you want to launch from. :3  They automatically reap themselves after 10 seconds (adjustable by changing length of the animation).

Could be useful for some puzzle maps or something, maybe.
