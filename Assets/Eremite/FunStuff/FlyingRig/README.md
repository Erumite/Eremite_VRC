# Flying Rig
#### Codename: Magic Carpet Ride
New setup of the flying rig that works pretty decently with after version 772.

Improved a bit with some configurable joint and rigidbody magic to allow control:
* Look up to gain altitude.
* Look down to fly downward/land.
* Toggle the flying off for quick descent.
* Smooth hovering while standing still, very slow altitude loss.

### Preview, kinda:
![](https://i.imgur.com/7M90HU5.png)

### Setup
1. Drag the `lolfly` prefab into the avatar game object (alongside armature/body)
2. Drag the `fly_target` prefab into the armature as a child of the head.
3. Select `lolfly/pitterpat` and set `fly_target` as Configurable Joint's `Connected Body`
4. Add or edit the `takeoff` animation to your overrides.

Optional:
5. Disable the mesh renderer for `lolfly/pitterpat` and add your own effects.  It's just there to demo how it works.
6. Tweak the `High Angular X Limit` of `Configurable Joint` to fine-tune how it adjusts to gain/lower altitude.  Essentially how many degrees your head must go up/down before the collider starts to shift its angle.  I find ~30 degrees is a good mix of stability and control.

### Troubleshooting
*(This looks like a lot of things that can go wrong, but overall it's very stable.)*

Your mileage may vary depending on the walking/running/crouching/etc animation that you are using.

This works fantastically with my own animation, but the default walk animations for VRChat act strangely; Looking downward causes the avatar to shoot forward pretty quickly.  This may be desirable for some people, so play with different movement animations until you find something that fits the flying style you want.

If you want pure smooth flying with no odd boosting, try tweaking the settings on a custom walk animation to match the ones in the demo:

![](https://i.imgur.com/dcejmDv.png)

If you jump and get launched sideways when it's not activated, try moving it down a bit more.  Sometimes you'll bump into the collider while falling and get booted to the side.  I find this kindof humorous, but you could probably get around it by having the collider above you by default rather than below, then moving it to `0,0,0` in the animation.

You can jump to gain altitude faster **while moving**, but stationary jumping will likely launch you sideways.  If you find yourself in free fall, try moving forward and jumping to get control back.
