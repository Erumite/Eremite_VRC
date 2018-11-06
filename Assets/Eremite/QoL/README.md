# Quality-Of-Life Prefabs
Just some stuff I've whipped together to save some time and improve workflow when working on stuff in Unity.

##### Prefabs:
* **AvatarBG**: Avatar background, automatically scaled and moved into place.  Just drop it into the scene and hit build.
  * By default, it will be centered behind the avatar.  You can re-parent the `VRCCam_POS` child object to the `VRCCam` object while building and it will stay in position as you move the camera around to get the angle you want.
  * To have the background by itself, you can just disable the avatar or do the above and move the cam so the avatar is out of view.
