// Shader created with Shader Forge v1.38
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:1,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:False,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:1,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:6,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:1,qpre:4,rntp:5,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:36073,y:33885,varname:node_2865,prsc:2|emission-4047-OUT;n:type:ShaderForge.SFN_ScreenPos,id:5932,x:35486,y:35357,varname:node_5932,prsc:2,sctp:2;n:type:ShaderForge.SFN_Set,id:1564,x:35641,y:35349,varname:ScreenPosUV,prsc:2|IN-5932-UVOUT;n:type:ShaderForge.SFN_Set,id:2968,x:35641,y:35403,varname:ScreenPosU,prsc:2|IN-5932-U;n:type:ShaderForge.SFN_Set,id:7539,x:35638,y:35450,varname:ScreenPosV,prsc:2|IN-5932-V;n:type:ShaderForge.SFN_Slider,id:826,x:35299,y:35287,ptovrint:False,ptlb:Line Thickness,ptin:_LineThickness,varname:node_826,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:0.01;n:type:ShaderForge.SFN_Set,id:6131,x:35641,y:35281,varname:BlurAmount,prsc:2|IN-826-OUT;n:type:ShaderForge.SFN_SceneColor,id:2647,x:33902,y:33894,varname:node_2647,prsc:2|UVIN-6885-OUT;n:type:ShaderForge.SFN_Get,id:4927,x:33404,y:33857,varname:node_4927,prsc:2|IN-2968-OUT;n:type:ShaderForge.SFN_Append,id:6885,x:33738,y:33894,varname:node_6885,prsc:2|A-8583-OUT,B-4182-OUT;n:type:ShaderForge.SFN_Add,id:8583,x:33574,y:33872,varname:node_8583,prsc:2|A-4927-OUT,B-968-OUT;n:type:ShaderForge.SFN_Get,id:968,x:33404,y:33905,varname:node_968,prsc:2|IN-6131-OUT;n:type:ShaderForge.SFN_Get,id:4182,x:33553,y:33997,varname:node_4182,prsc:2|IN-7539-OUT;n:type:ShaderForge.SFN_SceneColor,id:5948,x:33886,y:34126,varname:node_5948,prsc:2|UVIN-9191-OUT;n:type:ShaderForge.SFN_Get,id:3212,x:33388,y:34089,varname:node_3212,prsc:2|IN-2968-OUT;n:type:ShaderForge.SFN_Append,id:9191,x:33722,y:34126,varname:node_9191,prsc:2|A-9704-OUT,B-9229-OUT;n:type:ShaderForge.SFN_Add,id:9704,x:33558,y:34104,varname:node_9704,prsc:2|A-3212-OUT,B-191-OUT;n:type:ShaderForge.SFN_Get,id:2298,x:33245,y:34159,varname:node_2298,prsc:2|IN-6131-OUT;n:type:ShaderForge.SFN_Get,id:9229,x:33537,y:34229,varname:node_9229,prsc:2|IN-7539-OUT;n:type:ShaderForge.SFN_RemapRange,id:191,x:33409,y:34159,varname:node_191,prsc:2,frmn:0,frmx:1,tomn:0,tomx:-1|IN-2298-OUT;n:type:ShaderForge.SFN_SceneColor,id:3245,x:33850,y:34392,varname:node_3245,prsc:2|UVIN-8764-OUT;n:type:ShaderForge.SFN_Get,id:5896,x:33352,y:34355,varname:node_5896,prsc:2|IN-7539-OUT;n:type:ShaderForge.SFN_Append,id:8764,x:33686,y:34392,varname:node_8764,prsc:2|A-7273-OUT,B-3606-OUT;n:type:ShaderForge.SFN_Add,id:3606,x:33527,y:34392,varname:node_3606,prsc:2|A-5896-OUT,B-3267-OUT;n:type:ShaderForge.SFN_Get,id:3267,x:33352,y:34403,varname:node_3267,prsc:2|IN-6131-OUT;n:type:ShaderForge.SFN_Get,id:7273,x:33537,y:34336,varname:node_7273,prsc:2|IN-2968-OUT;n:type:ShaderForge.SFN_SceneColor,id:1216,x:33834,y:34624,varname:node_1216,prsc:2|UVIN-2895-OUT;n:type:ShaderForge.SFN_Get,id:6143,x:33336,y:34587,varname:node_6143,prsc:2|IN-7539-OUT;n:type:ShaderForge.SFN_Append,id:2895,x:33670,y:34624,varname:node_2895,prsc:2|A-3964-OUT,B-8221-OUT;n:type:ShaderForge.SFN_Add,id:8221,x:33506,y:34602,varname:node_8221,prsc:2|A-6143-OUT,B-5651-OUT;n:type:ShaderForge.SFN_Get,id:4309,x:33192,y:34657,varname:node_4309,prsc:2|IN-6131-OUT;n:type:ShaderForge.SFN_Get,id:3964,x:33506,y:34555,varname:node_3964,prsc:2|IN-2968-OUT;n:type:ShaderForge.SFN_RemapRange,id:5651,x:33357,y:34657,varname:node_5651,prsc:2,frmn:0,frmx:1,tomn:0,tomx:-1|IN-4309-OUT;n:type:ShaderForge.SFN_SceneColor,id:964,x:34124,y:35930,varname:node_964,prsc:2|UVIN-3249-OUT;n:type:ShaderForge.SFN_Add,id:3249,x:33922,y:35930,varname:node_3249,prsc:2|A-6478-OUT,B-9452-OUT;n:type:ShaderForge.SFN_Get,id:9452,x:33683,y:35978,varname:node_9452,prsc:2|IN-6131-OUT;n:type:ShaderForge.SFN_Get,id:6478,x:33683,y:35930,varname:node_6478,prsc:2|IN-1564-OUT;n:type:ShaderForge.SFN_SceneColor,id:3798,x:34037,y:35723,varname:node_3798,prsc:2|UVIN-7335-OUT;n:type:ShaderForge.SFN_Add,id:7335,x:33835,y:35723,varname:node_7335,prsc:2|A-9017-OUT,B-9097-OUT;n:type:ShaderForge.SFN_Get,id:4196,x:33510,y:35752,varname:node_4196,prsc:2|IN-6131-OUT;n:type:ShaderForge.SFN_Get,id:9017,x:33525,y:35697,varname:node_9017,prsc:2|IN-1564-OUT;n:type:ShaderForge.SFN_RemapRange,id:9097,x:33674,y:35752,varname:node_9097,prsc:2,frmn:0,frmx:1,tomn:0,tomx:-1|IN-4196-OUT;n:type:ShaderForge.SFN_SceneColor,id:3446,x:34030,y:35346,varname:node_3446,prsc:2|UVIN-5607-OUT;n:type:ShaderForge.SFN_Add,id:1497,x:33653,y:35314,varname:node_1497,prsc:2|A-6734-OUT,B-9012-OUT;n:type:ShaderForge.SFN_Get,id:2084,x:33203,y:35361,varname:node_2084,prsc:2|IN-6131-OUT;n:type:ShaderForge.SFN_Get,id:6734,x:33343,y:35303,varname:node_6734,prsc:2|IN-2968-OUT;n:type:ShaderForge.SFN_RemapRange,id:9012,x:33491,y:35359,varname:node_9012,prsc:2,frmn:0,frmx:1,tomn:0,tomx:-1|IN-2084-OUT;n:type:ShaderForge.SFN_Add,id:7247,x:33550,y:35521,varname:node_7247,prsc:2|A-2084-OUT,B-8025-OUT;n:type:ShaderForge.SFN_Get,id:8025,x:33237,y:35537,varname:node_8025,prsc:2|IN-7539-OUT;n:type:ShaderForge.SFN_Append,id:5607,x:33855,y:35357,varname:node_5607,prsc:2|A-1497-OUT,B-7247-OUT;n:type:ShaderForge.SFN_SceneColor,id:3197,x:33977,y:34986,varname:node_3197,prsc:2|UVIN-3356-OUT;n:type:ShaderForge.SFN_Append,id:3356,x:33816,y:34986,varname:node_3356,prsc:2|A-5116-OUT,B-1195-OUT;n:type:ShaderForge.SFN_Add,id:5116,x:33558,y:35136,varname:node_5116,prsc:2|A-1739-OUT,B-5484-OUT;n:type:ShaderForge.SFN_Add,id:1195,x:33651,y:34935,varname:node_1195,prsc:2|A-9275-OUT,B-6879-OUT;n:type:ShaderForge.SFN_RemapRange,id:6879,x:33478,y:34955,varname:node_6879,prsc:2,frmn:0,frmx:1,tomn:0,tomx:-1|IN-1739-OUT;n:type:ShaderForge.SFN_Get,id:9275,x:33327,y:34919,varname:node_9275,prsc:2|IN-7539-OUT;n:type:ShaderForge.SFN_Get,id:1739,x:33121,y:35006,varname:node_1739,prsc:2|IN-6131-OUT;n:type:ShaderForge.SFN_Get,id:5484,x:33223,y:35151,varname:node_5484,prsc:2|IN-2968-OUT;n:type:ShaderForge.SFN_SceneColor,id:52,x:33809,y:34821,varname:node_52,prsc:2|UVIN-3788-OUT;n:type:ShaderForge.SFN_Get,id:3788,x:33630,y:34821,varname:node_3788,prsc:2|IN-1564-OUT;n:type:ShaderForge.SFN_Add,id:6895,x:34281,y:34810,varname:node_6895,prsc:2|A-2647-RGB,B-5948-RGB,C-3245-RGB,D-1216-RGB,E-52-RGB;n:type:ShaderForge.SFN_Add,id:6423,x:34281,y:34989,varname:node_6423,prsc:2|A-3197-RGB,B-3446-RGB,C-3798-RGB,D-964-RGB;n:type:ShaderForge.SFN_Add,id:8395,x:34506,y:34887,varname:node_8395,prsc:2|A-6895-OUT,B-6423-OUT;n:type:ShaderForge.SFN_Divide,id:5323,x:34743,y:34887,varname:node_5323,prsc:2|A-8395-OUT,B-3511-OUT;n:type:ShaderForge.SFN_Vector1,id:3511,x:34528,y:35060,varname:node_3511,prsc:2,v1:9;n:type:ShaderForge.SFN_Set,id:1795,x:34976,y:34994,cmnt:blur effect,varname:Blur,prsc:2|IN-5323-OUT;n:type:ShaderForge.SFN_Get,id:3364,x:34276,y:34010,varname:node_3364,prsc:2|IN-1795-OUT;n:type:ShaderForge.SFN_SceneColor,id:1571,x:34534,y:33882,varname:node_1571,prsc:2|UVIN-2102-OUT;n:type:ShaderForge.SFN_Get,id:2102,x:34276,y:33882,varname:node_2102,prsc:2|IN-1564-OUT;n:type:ShaderForge.SFN_OneMinus,id:3313,x:34534,y:34010,varname:node_3313,prsc:2|IN-3364-OUT;n:type:ShaderForge.SFN_Vector1,id:4990,x:34524,y:34145,varname:node_4990,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Lerp,id:1396,x:34803,y:33976,varname:node_1396,prsc:2|A-1571-RGB,B-3313-OUT,T-4990-OUT;n:type:ShaderForge.SFN_Desaturate,id:1311,x:35025,y:33976,varname:node_1311,prsc:2|COL-1396-OUT;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:7845,x:35256,y:33987,varname:node_7845,prsc:2|IN-1311-OUT,IMIN-300-OUT,IMAX-5318-OUT,OMIN-770-OUT,OMAX-7955-OUT;n:type:ShaderForge.SFN_Vector1,id:300,x:34993,y:34098,varname:node_300,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:5318,x:34993,y:34149,varname:node_5318,prsc:2,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:770,x:34993,y:34232,ptovrint:False,ptlb:Out Black,ptin:_OutBlack,varname:node_770,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:7955,x:34993,y:34310,ptovrint:False,ptlb:Out White,ptin:_OutWhite,varname:_OutBlack_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Power,id:6726,x:35504,y:33987,varname:node_6726,prsc:2|VAL-7845-OUT,EXP-5547-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5547,x:35256,y:34162,ptovrint:False,ptlb:Sharp,ptin:_Sharp,varname:_OutWhite_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Clamp01,id:4047,x:35701,y:33987,varname:node_4047,prsc:2|IN-6726-OUT;n:type:ShaderForge.SFN_Get,id:1769,x:35701,y:33879,varname:node_1769,prsc:2|IN-1795-OUT;proporder:826-770-7955-5547;pass:END;sub:END;*/

Shader "Eremite/hand_drawn/dark" {
    Properties {
        _LineThickness ("Line Thickness", Range(0, 0.01)) = 0
        _OutBlack ("Out Black", Float ) = 0
        _OutWhite ("Out White", Float ) = 0
        _Sharp ("Sharp", Float ) = 0
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Overlay+1"
            "RenderType"="Overlay"
        }
        GrabPass{ }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            ZTest Always
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
            uniform float _LineThickness;
            uniform float _OutBlack;
            uniform float _OutWhite;
            uniform float _Sharp;
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
////// Emissive:
                float2 ScreenPosUV = sceneUVs.rg;
                float ScreenPosU = sceneUVs.r;
                float BlurAmount = _LineThickness;
                float ScreenPosV = sceneUVs.g;
                float node_1739 = BlurAmount;
                float node_2084 = BlurAmount;
                float3 Blur = (((tex2D( _GrabTexture, float2((ScreenPosU+BlurAmount),ScreenPosV)).rgb+tex2D( _GrabTexture, float2((ScreenPosU+(BlurAmount*-1.0+0.0)),ScreenPosV)).rgb+tex2D( _GrabTexture, float2(ScreenPosU,(ScreenPosV+BlurAmount))).rgb+tex2D( _GrabTexture, float2(ScreenPosU,(ScreenPosV+(BlurAmount*-1.0+0.0)))).rgb+tex2D( _GrabTexture, ScreenPosUV).rgb)+(tex2D( _GrabTexture, float2((node_1739+ScreenPosU),(ScreenPosV+(node_1739*-1.0+0.0)))).rgb+tex2D( _GrabTexture, float2((ScreenPosU+(node_2084*-1.0+0.0)),(node_2084+ScreenPosV))).rgb+tex2D( _GrabTexture, (ScreenPosUV+(BlurAmount*-1.0+0.0))).rgb+tex2D( _GrabTexture, (ScreenPosUV+BlurAmount)).rgb))/9.0); // blur effect
                float node_300 = 0.0;
                float node_4047 = saturate(pow((_OutBlack + ( (dot(lerp(tex2D( _GrabTexture, ScreenPosUV).rgb,(1.0 - Blur),0.5),float3(0.3,0.59,0.11)) - node_300) * (_OutWhite - _OutBlack) ) / (1.0 - node_300)),_Sharp));
                float3 emissive = float3(node_4047,node_4047,node_4047);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
