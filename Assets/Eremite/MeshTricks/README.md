# Mesh Tricks
These are just some useful meshes that I've used in world/avatar creation.  They are either:

* Shapes that unity doesn't provide.
* Lower poly versions of default unity objects.
* Shapes with normals inverted or tweaked to exploit collision or material rendering.
---
### List of junk:
###### Inverted Normals:
* **5-side-cube-trap**: Inverted normal cube with one side deleted.  Useful for trapping things inside it while allowing one side as an exit.
* **inverted_cube**: Cube with flipped normals.
* **inverted_sphere_lowpoly**: A lower-poly version of a sphere with inverted normals.
* **inverted_cylinder** : Exactly what it sounds like.

###### Utility:
* **2-sided plane**: A two-sided plane that shows the same image on both sides; one mesh, 4 tris.
* **2-sided plane mirrored**: Same as above, but the image is mirrored on the other side.  (EG: `d` becomes `b`)
* **circle_1-sided**: A circle only visible from one side. 32-tri
* **circle_2-sided**: Same as above, but duped to be visible from both sides.
* **torus_(donut-ring)**: A torus/ring/donut shape since Unity doesn't seem to have one by default.

###### Map Stuff:
* **terrain_grass_cross**: back-to-back quads in an X-shape for a nice grass effect without using terrain grass.
