// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Eremite/GreenscreenHolographic"
{
	Properties
	{
		_RenderTex("RenderTex", 2D) = "white" {}
		_ChromaKey("ChromaKey", Color) = (0,1,0,0)
		_MaskClipValue("MaskClipValue", Range( 0 , 1)) = 0.75
		_Smoothing("Smoothing", Range( 0 , 1)) = 0.6
		_HologramTex("HologramTex", 2D) = "white" {}
		_HologramScroll("HologramScroll", Vector) = (0,0.2,0,0)
		_PixelateUVsXY("PixelateUVsXY", Vector) = (420,69,0,0)
		_HologramBrightness("HologramBrightness", Range( 1 , 5)) = 1
		_HologramColor("HologramColor", Color) = (1,1,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow exclude_path:deferred noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _RenderTex;
		uniform float4 _RenderTex_ST;
		uniform float4 _ChromaKey;
		uniform float _Smoothing;
		uniform float _MaskClipValue;
		uniform sampler2D _HologramTex;
		uniform float2 _HologramScroll;
		uniform float2 _PixelateUVsXY;
		uniform float _HologramBrightness;
		uniform float4 _HologramColor;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_RenderTex = i.uv_texcoord * _RenderTex_ST.xy + _RenderTex_ST.zw;
			float4 break9 = tex2D( _RenderTex, uv_RenderTex );
			float texRed10 = break9.r;
			float texGreen11 = break9.g;
			float texBlue12 = break9.b;
			float4 appendResult32 = (float4(texRed10 , texGreen11 , texBlue12 , 0.0));
			float4 chromaRGB44 = _ChromaKey;
			float chromaRed15 = _ChromaKey.r;
			float chromaGreen14 = _ChromaKey.g;
			float chromaBlue13 = _ChromaKey.b;
			float OpacityMask72 = max( max( abs( ( texRed10 - chromaRed15 ) ) , abs( ( texGreen11 - chromaGreen14 ) ) ) , abs( ( texBlue12 - chromaBlue13 ) ) );
			float smoothing76 = ( (0.0 + (_Smoothing - 0.0) * (( 1.0 - _MaskClipValue ) - 0.0) / (1.0 - 0.0)) + _MaskClipValue );
			float2 panner86 = ( 1.0 * _Time.y * _HologramScroll + i.uv_texcoord);
			float pixelWidth101 =  1.0f / _PixelateUVsXY.x;
			float pixelHeight101 = 1.0f / _PixelateUVsXY.y;
			half2 pixelateduv101 = half2((int)(panner86.x / pixelWidth101) * pixelWidth101, (int)(panner86.y / pixelHeight101) * pixelHeight101);
			float4 Hologram81 = tex2D( _HologramTex, pixelateduv101 );
			o.Emission = ( ( appendResult32 - ( chromaRGB44 * step( OpacityMask72 , smoothing76 ) ) ) * OpacityMask72 * ( saturate( ( Hologram81 * _HologramBrightness ) ) * _HologramColor ) ).xyz;
			o.Alpha = ( Hologram81 * OpacityMask72 ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18000
1934;43;1906;984;1717.986;171.5011;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-1366.855,-75.1338;Inherit;True;Property;_RenderTex;RenderTex;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;9;-1086.227,-69.88272;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;2;-2044.627,-386.8727;Float;False;Property;_ChromaKey;ChromaKey;1;0;Create;True;0;0;False;0;0,1,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;75;-2589.158,694.6602;Inherit;False;1036.797;544.3142;Generate Opacity Mask By Finding Max Difference From ChromaKey;15;17;20;21;22;24;25;19;23;18;26;47;27;16;48;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-1799.408,-409.2632;Float;False;chromaRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-841.2277,-118.8829;Float;False;texRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-1798.408,-342.2632;Float;False;chromaGreen;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-840.2277,-51.88274;Float;False;texGreen;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-1798.408,-273.2631;Float;False;chromaBlue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-840.2277,17.11737;Float;False;texBlue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-2539.158,973.6608;Inherit;False;14;chromaGreen;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-2513.158,898.6607;Inherit;False;11;texGreen;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-2504.158,744.6603;Inherit;False;10;texRed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;17;-2524.158,814.6606;Inherit;False;15;chromaRed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;78;-2610.328,314.3664;Inherit;False;1087.025;349.4005;Find Smoothing Value, ramap so clip doesn't go above 1.0;6;71;7;6;70;46;76;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;88;-1468.51,-652.0751;Float;False;Property;_HologramScroll;HologramScroll;5;0;Create;True;0;0;False;0;0,0.2;0,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;24;-2511.905,1051.975;Inherit;False;12;texBlue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2560.328,548.7667;Float;False;Property;_MaskClipValue;MaskClipValue;2;0;Create;True;0;0;False;0;0.75;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-2329.158,927.6607;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;87;-1472.51,-766.0751;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;19;-2330.158,769.6604;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-2531.905,1123.975;Inherit;False;13;chromaBlue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;70;-2282.766,503.6971;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;86;-1226.51,-673.0751;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-2334.905,1074.975;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;102;-1285.5,-549.0709;Float;False;Property;_PixelateUVsXY;PixelateUVsXY;6;0;Create;True;0;0;False;0;420,69;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.AbsOpNode;23;-2194.158,930.6607;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-2385.427,364.3663;Float;False;Property;_Smoothing;Smoothing;3;0;Create;True;0;0;False;0;0.6;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;18;-2192.157,771.6604;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;27;-2193.905,1074.975;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;71;-2096.766,407.6971;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;47;-2071.783,840.009;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCPixelate;101;-1019.51,-557.0751;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1024;False;2;FLOAT;1024;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;48;-1950.201,940.2624;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-1898.77,527.8092;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;79;-810.6575,-634.3187;Inherit;True;Property;_HologramTex;HologramTex;4;0;Create;True;0;0;False;0;-1;bfe4769db15cb2940b1d758cc8406bc4;bfe4769db15cb2940b1d758cc8406bc4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;72;-1795.361,939.8087;Float;False;OpacityMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;76;-1766.301,522.3025;Float;False;smoothing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;81;-0.5100098,-624.0751;Float;False;Hologram;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;74;-1279.259,140.9942;Inherit;False;72;OpacityMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;82;-927.51,234.9249;Inherit;False;81;Hologram;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;-1276.148,219.3868;Inherit;False;76;smoothing;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-1798.24,-482.634;Float;False;chromaRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-997.9908,318.7342;Float;False;Property;_HologramBrightness;HologramBrightness;7;0;Create;True;0;0;False;0;1;0;1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-707.9908,299.7342;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;43;-1060.302,158.2979;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-872.424,122.9031;Inherit;False;44;chromaRGB;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-616.8041,130.3977;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;99;-575.51,296.9249;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;32;-608.9038,-69.10175;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;108;-740.0557,393.7529;Float;False;Property;_HologramColor;HologramColor;8;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;39;-435.9039,28.59791;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;-419.0557,320.7529;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-411.7352,427.5351;Inherit;False;72;OpacityMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-138.51,194.9249;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-223.51,30.92487;Inherit;False;3;3;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,-13;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Eremite/GreenscreenHolographic;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;1;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexScale;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;6;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;1;0
WireConnection;15;0;2;1
WireConnection;10;0;9;0
WireConnection;14;0;2;2
WireConnection;11;0;9;1
WireConnection;13;0;2;3
WireConnection;12;0;9;2
WireConnection;22;0;21;0
WireConnection;22;1;20;0
WireConnection;19;0;16;0
WireConnection;19;1;17;0
WireConnection;70;0;6;0
WireConnection;86;0;87;0
WireConnection;86;2;88;0
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;23;0;22;0
WireConnection;18;0;19;0
WireConnection;27;0;26;0
WireConnection;71;0;7;0
WireConnection;71;4;70;0
WireConnection;47;0;18;0
WireConnection;47;1;23;0
WireConnection;101;0;86;0
WireConnection;101;1;102;1
WireConnection;101;2;102;2
WireConnection;48;0;47;0
WireConnection;48;1;27;0
WireConnection;46;0;71;0
WireConnection;46;1;6;0
WireConnection;79;1;101;0
WireConnection;72;0;48;0
WireConnection;76;0;46;0
WireConnection;81;0;79;0
WireConnection;44;0;2;0
WireConnection;106;0;82;0
WireConnection;106;1;107;0
WireConnection;43;0;74;0
WireConnection;43;1;77;0
WireConnection;40;0;45;0
WireConnection;40;1;43;0
WireConnection;99;0;106;0
WireConnection;32;0;10;0
WireConnection;32;1;11;0
WireConnection;32;2;12;0
WireConnection;39;0;32;0
WireConnection;39;1;40;0
WireConnection;109;0;99;0
WireConnection;109;1;108;0
WireConnection;84;0;82;0
WireConnection;84;1;73;0
WireConnection;80;0;39;0
WireConnection;80;1;73;0
WireConnection;80;2;109;0
WireConnection;0;2;80;0
WireConnection;0;9;84;0
ASEEND*/
//CHKSM=6F47EF5CD5F1D888C25D6F34539FC1C84AB91CC2