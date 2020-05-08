# Custom Nametag
Experimental method of hiding nametags without using massive spheres/cubes that block out a lot of transparent-queue+ objects in the background.  

Basically just a cube with a 2999 render queue that passes whatever's behind it before the Transparent-queued (3000) nametag is shown.

## Usage:
Drag prefab into avatar's game object, alongside armature.  Don't put it in armature or it won't match the name plate's movement.

Use the included sample nametag file or the `.xcf` file in [Gimp](https://www.gimp.org/) to add your custom texture if required.  Or just add a small transparent png to only hide the nametag.

| Setting | Description |
| --- | --- |
|NameTagTex|Texture of nametag|
|EmissionTex|Emission Texture|

The sizing is probably about right as-is, but the Y value is going to need some tweaking.  Some tips:
* Drag the nameplate prefab out of your avatar and into world space.
* Set the Y value to your viewball Y-value + .5
* Set X to Zero
* Set Z value to the Z value of your viewball.
* Drag the nameplate prefab back into your avatar's game object.
* Upload and test position:
  * If you move under the nametag and the real tag pops out the top, you probably need to move the mesh up (and vice versa)
  * If it's visible from the front, move the mesh forward, and vice versa.

Upload, test with a 2nd client or a friend till it looks right.

#### Spritesheet Generation with ImageMagick

Example: Create a 3x3 spritesheet of 800x200 images named frame[0-9].png.
```
montage frame*.png -tile 3x3 -geometry 800x200+0+0 -background transparent spritesheet.png
```

## Flipbook Variant
| Setting | Description |
| --- | --- |
| Flip | Show the reverse side of the nametag (in an animation override)|
|NameTagTex|Texture of nametag, ordered into a spritesheet|
|Emission|Emission multiplier (uses main texture)|
|Columns|Number of vertical columns in the spritesheet|
|Rows|Number of horizontal rows in the spritesheet|
|StartFrame|Start at X frame in the sheet|
|Speed|How fast it should switch sheet frames|

## Warnings:
There seems to be some contention about whether or not this is against the TOS.  Use common sense and avoid using it maliciously.  The TOS explicitly bans:

* "Impersonating a VRChat employee."
* "You may not falsely identify yourself as another individual or group."

In theory, this means that simply hiding your name plate or adding a custom one isn't against TOS.  Altering the frames to imitate a different trust rank, add or remove friend or other nametag icons, change username, impersonate a mod, etc are done at your own risk and will likely be actionable.

As of May 8, 2020, there's a new addendum under `Avatar Modifications`: 

* Adding features to your avatar with the intention of misleading other users about functionality of VRChat is not allowed.
* Avatars must not hide, obstruct, add/remove elements from, or affect/modify the appearance of the VRChat UI (such as nameplates).

This was in response to this custom nameplate (which is much better than my version): 
https://www.patreon.com/posts/vanity-download-36841063
https://www.patreon.com/posts/36901943

Relevant canny post: https://vrchat.canny.io/feature-requests/p/specify-malicious-use-in-the-community-guidelines-for-nameplate-modification

## Issues:
Doesn't show up right in mirrors.  The mirror reflects the name tag as you'd expect it to based on its rotation in the world, while the shader will always face the camera on both the real and mirror reflected versions.  This shouldn't be a problem in most worlds as most people disable UI/nametags in the mirror as part of optimizations.

![](https://cdn.discordapp.com/attachments/432526944500973579/584523813786484864/unknown.png)

It will hide anything in transparent queue behind it as well.  Portals, avatar pedestal previews, others' nametags, etc.

It's also visible to yourself when you look up, but that's to be expected.

### ToDo:
Figure out best option for fallback shader when shaders are blocked.
Trying to figure out a way to get a depth-check to work so only nametag is hidden, not transparent effects behind it.

## Credits
The vertex position portion of the shader is adapted from [Vilar's Eye Tracking Shader](https://vrcat.club/threads/vilars-eye-tracking-shader.1640/) with the majority of the unnecessary settings removed to reduce calculations needed and simplify configuration.

Thanks to RollTheRed for suggesting the spritesheet animation variant. :3

---

#### Position Test Results - Making sense of where to put this thing.
| ViewBall Y | NameTag Y | ViewBall Z | NameTag Z | Y Offset | Z Offset |
| ---------- | --------- | ---------- | --------- | -------- | -------- |
| 0.865      | 1.70625   | 0.01       | 0.0125    | +0.84125 | +0.0025  |
| 0.85       | 1.4       | 0.02       | 0.01      | +0.55    | -0.01    |

Please DM me your ViewBall position and final nametag position if you get it working properly for more data points.  

Positioning doesn't make much sense so far with a sample size of 2.  Possibly calculated from bounds size? 
