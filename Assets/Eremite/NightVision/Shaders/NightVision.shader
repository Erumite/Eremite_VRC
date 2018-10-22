// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:1,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:False,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:1,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:2,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:32918,y:33710,varname:node_2865,prsc:2|custl-8700-OUT;n:type:ShaderForge.SFN_SceneColor,id:8934,x:31144,y:33458,varname:node_8934,prsc:2;n:type:ShaderForge.SFN_Set,id:6753,x:31383,y:33473,varname:SceneRed,prsc:2|IN-8934-R;n:type:ShaderForge.SFN_Set,id:5037,x:31313,y:33529,varname:SceneGreen,prsc:2|IN-8934-G;n:type:ShaderForge.SFN_Set,id:1261,x:31313,y:33571,varname:SceneBlue,prsc:2|IN-8934-B;n:type:ShaderForge.SFN_Set,id:7068,x:31313,y:33616,varname:SceneAlpha,prsc:2|IN-8934-A;n:type:ShaderForge.SFN_Get,id:4983,x:31328,y:33696,varname:node_4983,prsc:2|IN-6753-OUT;n:type:ShaderForge.SFN_Divide,id:9016,x:31520,y:33696,varname:node_9016,prsc:2|A-4983-OUT,B-3635-OUT;n:type:ShaderForge.SFN_Get,id:5307,x:31328,y:33901,varname:node_5307,prsc:2|IN-5037-OUT;n:type:ShaderForge.SFN_Divide,id:9538,x:31520,y:33901,varname:node_9538,prsc:2|A-5307-OUT,B-156-OUT;n:type:ShaderForge.SFN_Get,id:2913,x:31341,y:34102,varname:node_2913,prsc:2|IN-1261-OUT;n:type:ShaderForge.SFN_Divide,id:8149,x:31520,y:34102,varname:node_8149,prsc:2|A-2913-OUT,B-4135-OUT;n:type:ShaderForge.SFN_Set,id:6056,x:31670,y:33696,varname:FinalRed,prsc:2|IN-9016-OUT;n:type:ShaderForge.SFN_Set,id:3443,x:31688,y:33901,varname:FinalGreen,prsc:2|IN-9538-OUT;n:type:ShaderForge.SFN_Set,id:7538,x:31674,y:34102,varname:FinalBlue,prsc:2|IN-8149-OUT;n:type:ShaderForge.SFN_Append,id:1876,x:32066,y:33730,varname:node_1876,prsc:2|A-1484-OUT,B-856-OUT;n:type:ShaderForge.SFN_Append,id:1382,x:32251,y:33801,varname:node_1382,prsc:2|A-1876-OUT,B-9250-OUT;n:type:ShaderForge.SFN_Get,id:1484,x:31890,y:33716,varname:node_1484,prsc:2|IN-6056-OUT;n:type:ShaderForge.SFN_Get,id:856,x:31890,y:33766,varname:node_856,prsc:2|IN-3443-OUT;n:type:ShaderForge.SFN_Get,id:9250,x:32029,y:33874,varname:node_9250,prsc:2|IN-7538-OUT;n:type:ShaderForge.SFN_Get,id:9187,x:32151,y:33974,varname:node_9187,prsc:2|IN-7068-OUT;n:type:ShaderForge.SFN_Append,id:6101,x:32418,y:33905,varname:node_6101,prsc:2|A-1382-OUT,B-9187-OUT;n:type:ShaderForge.SFN_Set,id:2299,x:31325,y:33432,varname:SceneRGB,prsc:2|IN-8934-RGB;n:type:ShaderForge.SFN_Multiply,id:8700,x:32685,y:33986,varname:node_8700,prsc:2|A-6101-OUT,B-9031-OUT,C-2017-RGB;n:type:ShaderForge.SFN_Get,id:2032,x:31882,y:34093,varname:node_2032,prsc:2|IN-6753-OUT;n:type:ShaderForge.SFN_Get,id:6556,x:31882,y:34145,varname:node_6556,prsc:2|IN-1261-OUT;n:type:ShaderForge.SFN_Get,id:207,x:31882,y:34192,varname:node_207,prsc:2|IN-5037-OUT;n:type:ShaderForge.SFN_Max,id:3408,x:32071,y:34109,cmnt:Highest color value.,varname:node_3408,prsc:2|A-2032-OUT,B-6556-OUT,C-207-OUT;n:type:ShaderForge.SFN_Add,id:7457,x:32228,y:34162,varname:node_7457,prsc:2|A-3408-OUT,B-1611-OUT;n:type:ShaderForge.SFN_Divide,id:9031,x:32486,y:34039,varname:node_9031,prsc:2|A-3408-OUT,B-1726-OUT;n:type:ShaderForge.SFN_Slider,id:5867,x:31655,y:34300,ptovrint:False,ptlb:Sensitivity,ptin:_Sensitivity,varname:node_5867,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.8,max:1;n:type:ShaderForge.SFN_RemapRange,id:1611,x:32022,y:34294,cmnt:brightness boost amount,varname:node_1611,prsc:2,frmn:0,frmx:1,tomn:0.1,tomx:0.001|IN-5867-OUT;n:type:ShaderForge.SFN_Color,id:2017,x:32557,y:34278,ptovrint:False,ptlb:HueMod,ptin:_HueMod,cmnt:Optional Hue to apply to effect. EG Nightvision green ,varname:node_2017,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Max,id:1726,x:32379,y:34204,varname:node_1726,prsc:2|A-7457-OUT,B-8065-OUT;n:type:ShaderForge.SFN_Set,id:815,x:31702,y:33575,varname:RGBTotal,prsc:2|IN-3897-OUT;n:type:ShaderForge.SFN_Get,id:7326,x:31572,y:33380,varname:node_7326,prsc:2|IN-6753-OUT;n:type:ShaderForge.SFN_Add,id:3897,x:31752,y:33408,varname:node_3897,prsc:2|A-7326-OUT,B-4965-OUT,C-1951-OUT;n:type:ShaderForge.SFN_Get,id:4965,x:31572,y:33433,varname:node_4965,prsc:2|IN-5037-OUT;n:type:ShaderForge.SFN_Get,id:1951,x:31572,y:33487,varname:node_1951,prsc:2|IN-1261-OUT;n:type:ShaderForge.SFN_Vector1,id:6906,x:31999,y:33480,cmnt:a super low number to avoid divide by zero NaNs,varname:node_6906,prsc:2,v1:1E-10;n:type:ShaderForge.SFN_Max,id:3635,x:31349,y:33751,cmnt:avoid div by 0 NaNs,varname:node_3635,prsc:2|A-932-OUT,B-4224-OUT;n:type:ShaderForge.SFN_Get,id:4224,x:31176,y:33803,varname:node_4224,prsc:2|IN-815-OUT;n:type:ShaderForge.SFN_Max,id:156,x:31349,y:33951,cmnt:avoid div by 0 NaNs,varname:node_156,prsc:2|A-6478-OUT,B-3374-OUT;n:type:ShaderForge.SFN_Get,id:3374,x:31176,y:34005,varname:node_3374,prsc:2|IN-815-OUT;n:type:ShaderForge.SFN_Max,id:4135,x:31362,y:34154,cmnt:avoid div by 0 NaNs,varname:node_4135,prsc:2|A-1219-OUT,B-655-OUT;n:type:ShaderForge.SFN_Get,id:655,x:31189,y:34208,varname:node_655,prsc:2|IN-815-OUT;n:type:ShaderForge.SFN_Set,id:9707,x:32145,y:33480,varname:superlowvalue,prsc:2|IN-6906-OUT;n:type:ShaderForge.SFN_Get,id:932,x:31176,y:33751,varname:node_932,prsc:2|IN-9707-OUT;n:type:ShaderForge.SFN_Get,id:6478,x:31176,y:33951,varname:node_6478,prsc:2|IN-9707-OUT;n:type:ShaderForge.SFN_Get,id:1219,x:31189,y:34154,varname:node_1219,prsc:2|IN-9707-OUT;n:type:ShaderForge.SFN_Get,id:8065,x:32207,y:34294,varname:node_8065,prsc:2|IN-9707-OUT;proporder:5867-2017;pass:END;sub:END;*/

Shader "Eremite/NightVision" {
    Properties {
        _Sensitivity ("Sensitivity", Range(0, 1)) = 0.8
        _HueMod ("HueMod", Color) = (1,1,1,1)
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent+2"
            "RenderType"="Transparent"
        }
        GrabPass{ }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform float _Sensitivity;
            uniform float4 _HueMod;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 projPos : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
                float4 node_8934 = sceneColor;
                float SceneRed = node_8934.r;
                float superlowvalue = 0.0000000001;
                float SceneGreen = node_8934.g;
                float SceneBlue = node_8934.b;
                float RGBTotal = (SceneRed+SceneGreen+SceneBlue);
                float FinalRed = (SceneRed/max(superlowvalue,RGBTotal));
                float FinalGreen = (SceneGreen/max(superlowvalue,RGBTotal));
                float FinalBlue = (SceneBlue/max(superlowvalue,RGBTotal));
                float SceneAlpha = node_8934.a;
                float node_3408 = max(max(SceneRed,SceneBlue),SceneGreen); // Highest color value.
                float3 finalColor = (float4(float3(float2(FinalRed,FinalGreen),FinalBlue),SceneAlpha)*(node_3408/max((node_3408+(_Sensitivity*-0.099+0.1)),superlowvalue))*_HueMod.rgb).rgb;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
