# Flying Rig
#### Codename: Magic Carpet Ride
New setup of the flying rig that works pretty decently with after version 772.

**This works best on desktop**, but is usable in VR with some practice.  
The problem with VR comes when you tilt your head side-to-side; this causes you to spin in the direction your head is tilted.

Improved a bit with some configurable joint and rigidbody magic to allow control:
* Look up to gain altitude.
* Look down to fly downward/land.
* Toggle the flying off for quick descent.
* Smooth hovering while standing still, very slow altitude loss.

### Preview, kinda:
![](https://i.imgur.com/7M90HU5.png)

### Setup
1. Drag the `DesktopFlyingPrefab` prefab into the scene.
2. Drag the `lolfly` game object into the avatar game object (alongside armature/body)
3. Drag the `fly_target` game object into the armature as a child of the head.
4. Add or edit the `takeoff` animation to your overrides.
*NOTE: The `lolfly/pitterpat` object should have its configurable joint's connected body set to `fly_target`.  It should stay linked since they're both in the prefab, but may need confirming if the plane isn't moving.*

Optional:
5. Disable the mesh renderer for `lolfly/pitterpat` and add your own effects.  It's just there to demo how it works.
6. Tweak the `High Angular X Limit` of `Configurable Joint` to fine-tune how it adjusts to gain/lower altitude.  
  * Essentially how many degrees your head must go up/down before the collider starts to shift its angle.  
  * I find ~30 degrees is a good mix of stability and control on desktop.
  * May want to raise this a good bit in VR if you like to look down while flying.

### Troubleshooting
*(This looks like a lot of things that can go wrong, but overall it's very stable.)*

Your mileage may vary depending on the walking/running/crouching/etc animation that you are using, as well as your rig setup.

**Make sure you have no problems with your humanoid rig** first and foremost.  Enforcing T-Pose can help with this.

This works fantastically with my own animation, but the default walk animations for VRChat act strangely; Looking downward causes the avatar to shoot forward pretty quickly.  This may be desirable for some people, so play with different movement animations until you find something that fits the flying style you want.

If you want pure smooth flying with no odd boosting, try tweaking the settings on a custom walk animation to match the ones in the demo:

![](https://i.imgur.com/dcejmDv.png)

If you jump and get launched sideways when it's not activated, try moving it down a bit more.  Sometimes you'll bump into the collider while falling and get booted to the side.  I find this kindof humorous, but you could probably get around it by having the collider above you by default rather than below, then moving it to `0,0,0` in the animation.

You can jump to gain altitude faster **while moving**, but stationary jumping will likely launch you sideways.  If you find yourself in free fall, try moving forward and jumping to get control back.
