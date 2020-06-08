# VRC_Station Fix
This is a fix for a problem with chairs introduced by the Unity 2018 update for VRChat.  
Chairs on avatars no longer work unless they are disabled by default and toggled on via an animation.  
This package is pretty much just a demo of how to get an "always-on" chair working again by using an animator to turn it on when the avatar loads.

#### Usage:
1. Drag Prefab into heirarchy where you want it.
 * EG: Hand/wrist bone to "pick up" people
2. Get it positioned right using the visualization sphere.
 * Drag the whole object, not just the sphere
3. Delete Visualization sphere or replace it with your own mesh.

The animator on the `VRCStationFix` object will enable the `VRC_Station` object, then disable its own animator for optimization.

The shape of the chair highlight on the avatar will match the collider on the `VRC_Station` object.  This is a sphere in the prefab, but can be changed to whatever.  
*Note: If no collider is specified, the highlight will default to a massive 1x1 cube, so you'll probably want to provide a collider.*

#### Extra stuff:
Splinks has a fixed chair prefab that combines well for avatar stations to give custom animations and fix the seated height on the station: https://github.com/splinks/VRChat-Customizable-Fixed-Chair

For info on how to tweak the station and make sure seated players are oriented correctly, see this wiki page: http://vrchat.wikidot.com/world-component:vrc-station
