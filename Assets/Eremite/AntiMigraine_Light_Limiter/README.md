# Anti-Migraine Light Limiter Shader

##### I AM NOT A DOCTOR. THIS IS NOT MEANT TO BE MEDICAL ADVICE.  NO SUE PLEASE.

A friend has an issue where very bright lights can cause pretty severe headaches and lead to migraines.  He suggested a shader that could limit/wash out bright lights.  [Flux](https://justgetflux.com/) was also mentioned as the red-tint can be helpful for avoiding eye "burnout".

I realized that the [NightVision](https://github.com/Erumite/Eremite_VRC/tree/master/Assets/Eremite/NightVision) shader I made already does almost all of that except limiting the maximum brightness, so I added that option.  I kept it as a separate shader to avoid unnecessary calculations on the main shader.  I also added a demo plane to the NV Demo scene.

##### Settings:
* **Sensitivity** : How much light in the scene is boosted. (Same as the night vision shader).  It helps to make color changes more uniform and avoid areas of extreme brightness.
* **HueMod**: Change the hue.  I set it to default to a color that looks like Flux's default orangey color. (No Blue Light)
* **MaxBrightness** : Multiply this value by the value for the pixel on the screen.  So, .5 will make all pixels be displayed at 1/2 of the calculated brightness.

##### Setup:
   Same as NightVision shader.  See [documentation](https://github.com/Erumite/Eremite_VRC/blob/master/Assets/Eremite/NightVision/README.md).

Hopefully this will be helpful and make VRChat more accessible to people with photosensitivity problems.
