# Silhouette Box
Just playing around with shaderforge to make a shadow box.  Anything that enters is projected as a "shadow" on the front of the box.

**Normal**:

![preview](https://i.imgur.com/5qWcj2k.png)

**Inverted**:

![preview](https://i.imgur.com/gx2VnTn.png)

There's an orthographic camera that only shows the `Player` layer and writes a solid color with 0 alpha as clear flags.

The shader just takes the alpha and passes it directly to the custom lighting input to create black/white (or shades of grey for semi-transparent objects).
