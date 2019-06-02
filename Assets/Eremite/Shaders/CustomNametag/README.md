# Custom Nametag
Experimental method of hiding nametags without using massive spheres/cubes that block out a lot of transparent-queue+ objects in the background.  Basically just a cube with a 2999 render queue that passes whatever's behind it before the Transparent-queued (3000) nametag is shown.

## Usage:
Drag prefab into avatar's game object, alongside armature.  Don't put it in armature or it won't match the name plate's movement.

Use the included sample nametag file or the `.xcf` file in [Gimp](https://www.gimp.org/) to add your custom texture if required.  Or just add a small transparent png to only hide the nametag.

| Setting | Description |
| --- | --- |
| Flip | Show the reverse side of the nametag (in an animation override)|
|NameTagTex|Texture of nametag|
|EmissionTex|Emission Texture|

The sizing is probably about right as-is, but the Y value is going to need some tweaking.  Some tips:
* Make sure the Z value matches taht of your ViewBall.
* Try setting the Y value to the Y value of your view ball plus ~0.9 to start with.

Upload, test with a 2nd client or a friend till it looks right.

## Credits
The vertex position portion of the shader is adapted from [Vilar's Eye Tracking Shader](https://vrcat.club/threads/vilars-eye-tracking-shader.1640/) with the majority of the unnecessary settings removed to reduce calculations needed and simplify configuration.

## Warnings:
There seems to be some contention about whether or not this is against the TOS.  Use common sense and avoid using it maliciously.  The TOS explicitly bans:

* "Impersonating a VRChat employee."
* "You may not falsely identify yourself as another individual or group."

In theory, this means that simply hiding your name plate or adding a custom one isn't against TOS.  Altering the frames to imitate a different trust rank, add or remove friend or other nametag icons, change username, impersonate a mod, etc are done at your own risk and will likely be actionable.

### ToDo:
Figure out best option for fallback shader when shaders are blocked.

## Issues:
Doesn't show up right in mirrors.  The mirror reflects the name tag as you'd expect it to based on its rotation in the world, while the shader will always face the camera on both the real and mirror reflected versions:

![](https://cdn.discordapp.com/attachments/432526944500973579/584523813786484864/unknown.png)

It's also visible to yourself when you look up, but that's to be expected.
