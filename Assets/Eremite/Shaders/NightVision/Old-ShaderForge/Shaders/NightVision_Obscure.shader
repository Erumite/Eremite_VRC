// Occlude anything rendered after this shader in the render queue.
Shader "Eremite/NVOld/Nightvision_Obscure" {
  SubShader {
    // Render just before transparent queue (nametags)
    Tags { "Queue"="Transparent+1" }
    Pass {
      Blend Zero One // keep the image behind it
    }
  }
}
