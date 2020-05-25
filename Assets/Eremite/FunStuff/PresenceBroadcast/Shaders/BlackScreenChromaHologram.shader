// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BlackScreenChromaHologram"
{
	Properties
	{
		_RenderTexture("RenderTexture", 2D) = "white" {}
		_HologramColor("HologramColor", Color) = (1,1,1,1)
		_Brightness("Brightness", Range( 0 , 1)) = 0
		_HologramTex("HologramTex", 2D) = "white" {}
		_HologramScroll("HologramScroll", Vector) = (0,0.2,0,0)
		_PixelateUVsXY("PixelateUVsXY", Vector) = (420,69,0,0)
		_OpacityFudge("OpacityFudge", Range( 0 , 10)) = 5
		_MinBrightness("MinBrightness", Range( 0 , 1)) = 0.1647059
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

		uniform sampler2D _RenderTexture;
		uniform float4 _RenderTexture_ST;
		uniform float _Brightness;
		uniform float _MinBrightness;
		uniform float4 _HologramColor;
		uniform sampler2D _HologramTex;
		uniform float2 _HologramScroll;
		uniform float2 _PixelateUVsXY;
		uniform float _OpacityFudge;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_RenderTexture = i.uv_texcoord * _RenderTexture_ST.xy + _RenderTexture_ST.zw;
			float4 inputTexture183 = tex2D( _RenderTexture, uv_RenderTexture );
			float4 break191 = inputTexture183;
			float temp_output_192_0 = ( break191.r + break191.g + break191.b );
			float4 appendResult199 = (float4(( break191.r / temp_output_192_0 ) , ( break191.g / temp_output_192_0 ) , ( break191.b / temp_output_192_0 ) , 0.0));
			float4 break186 = inputTexture183;
			float temp_output_194_0 = max( max( break186.r , break186.g ) , break186.b );
			float4 BrightenedChromaContent203 = saturate( ( appendResult199 * ( temp_output_194_0 / ( temp_output_194_0 + (0.0001 + (( 1.0 - _Brightness ) - 0.0) * (0.2 - 0.0001) / (1.0 - 0.0)) ) ) ) );
			float4 break211 = BrightenedChromaContent203;
			float temp_output_214_0 = max( max( break211.x , break211.y ) , break211.z );
			float4 ifLocalVar224 = 0;
			if( temp_output_214_0 < _MinBrightness )
				ifLocalVar224 = ( ( _MinBrightness - temp_output_214_0 ) + BrightenedChromaContent203 );
			float4 BrightBoost226 = ifLocalVar224;
			float2 panner209 = ( 1.0 * _Time.y * _HologramScroll + i.uv_texcoord);
			float pixelWidth212 =  1.0f / _PixelateUVsXY.x;
			float pixelHeight212 = 1.0f / _PixelateUVsXY.y;
			half2 pixelateduv212 = half2((int)(panner209.x / pixelWidth212) * pixelWidth212, (int)(panner209.y / pixelHeight212) * pixelHeight212);
			float4 Hologram218 = tex2D( _HologramTex, pixelateduv212 );
			o.Emission = ( ( BrightBoost226 + BrightenedChromaContent203 ) * _HologramColor * Hologram218 ).xyz;
			float4 break229 = ( Hologram218.a * _OpacityFudge * inputTexture183 );
			o.Alpha = max( max( break229.r , break229.g ) , break229.b );
		}

		ENDCG
	}
	Fallback "Standard"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18000
1927;8;1906;978;3678.263;844.7977;1;True;False
Node;AmplifyShaderEditor.SamplerNode;181;-3818.39,-771.2881;Inherit;True;Property;_RenderTexture;RenderTexture;0;0;Create;True;0;0;False;0;-1;088a4ead21b5e9744b41b802e259ad48;088a4ead21b5e9744b41b802e259ad48;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;182;-3292.395,-675.7154;Inherit;False;1192.631;456.9985;Find max of RGB to determine brightness(B). Read Sensitivity(S) :: B/(B+S) grows quickly at low values and slows as it approaches 1.0;10;200;196;194;193;190;189;188;187;186;184;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;183;-3510.513,-772.4031;Inherit;False;inputTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;184;-3232.954,-477.4739;Float;False;Property;_Brightness;Brightness;2;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;185;-3290.552,-1108.196;Inherit;False;1068.602;424.0002;Normalize Colors to be brighter based on ratio of R/G/B;6;199;198;197;195;192;191;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;186;-2979.691,-616.5074;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.OneMinusNode;187;-2823.144,-471.1384;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;188;-2921.764,-317.717;Inherit;False;Constant;_BrightnessMax;BrightnessMax;10;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-2919.764,-387.717;Inherit;False;Constant;_BrightnessMin;BrightnessMin;10;0;Create;True;0;0;False;0;0.0001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;191;-3015.988,-900.3048;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMaxOpNode;190;-2717.144,-625.7154;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;192;-2726.947,-1058.196;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;194;-2592.344,-595.8154;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;193;-2635.764,-470.7172;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;195;-2552.748,-917.7957;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;196;-2422.764,-497.7172;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;198;-2552.748,-831.9953;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;197;-2552.749,-1004.896;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;199;-2385.95,-959.3957;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;200;-2295.764,-566.717;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;201;-2034.046,-794.8843;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;202;-1837.659,-795.6257;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;204;-3511.613,-1663.014;Inherit;False;1873.572;489.3113;Set a Minimum Brightness for any portions of the brightened content whos max RGB values are below a threshold, preserving original color values.;9;226;224;219;217;216;214;213;211;207;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;203;-1699.756,-799.5647;Inherit;True;BrightenedChromaContent;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;205;-1379.384,-1373.072;Inherit;False;1256.741;428.0046;Generate Hologram Modifier;7;218;215;212;210;209;208;206;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;208;-1325.384,-1209.072;Float;False;Property;_HologramScroll;HologramScroll;4;0;Create;True;0;0;False;0;0,0.2;0,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;207;-3459.613,-1414.056;Inherit;True;203;BrightenedChromaContent;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;206;-1329.384,-1323.072;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;209;-1083.384,-1230.072;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;210;-1142.374,-1106.067;Float;False;Property;_PixelateUVsXY;PixelateUVsXY;5;0;Create;True;0;0;False;0;420,69;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.BreakToComponentsNode;211;-3102.897,-1511.53;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TFHCPixelate;212;-876.3833,-1114.071;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1024;False;2;FLOAT;1024;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;213;-2846.35,-1507.738;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;216;-2963.273,-1613.014;Inherit;False;Property;_MinBrightness;MinBrightness;7;0;Create;True;0;0;False;0;0.1647059;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;214;-2728.55,-1464.838;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;215;-667.5305,-1191.315;Inherit;True;Property;_HologramTex;HologramTex;3;0;Create;True;0;0;False;0;-1;bfe4769db15cb2940b1d758cc8406bc4;bfe4769db15cb2940b1d758cc8406bc4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;218;-365.6422,-1190.922;Float;False;Hologram;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;217;-2607.265,-1544.702;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;220;-1365.622,-404.3315;Inherit;True;218;Hologram;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;219;-2466.265,-1426.702;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ConditionalIfNode;224;-2172.265,-1609.702;Inherit;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;223;-1123.076,-346.1575;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;222;-1142.847,-131.7214;Inherit;True;183;inputTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;221;-1148.076,-211.1575;Inherit;False;Property;_OpacityFudge;OpacityFudge;6;0;Create;True;0;0;False;0;5;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;226;-1923.04,-1613.428;Inherit;True;BrightBoost;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;225;-777.6212,-257.5316;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;228;-1128.323,-721.4383;Inherit;False;226;BrightBoost;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;227;-1181.395,-651.9297;Inherit;False;203;BrightenedChromaContent;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;229;-553.1818,-258.1221;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMaxOpNode;230;-276.182,-248.1221;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;232;-1144.167,-573.5032;Float;False;Property;_HologramColor;HologramColor;1;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;231;-842.8594,-739.8039;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;235;-606.6211,-557.3314;Inherit;True;3;3;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.IntNode;234;-283.8233,-390.7148;Inherit;False;Constant;_Int0;Int 0;8;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;233;-276.182,-156.1221;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-44.6086,-639.0496;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;BlackScreenChromaHologram;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;1;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;1;5;False;-1;5;False;-1;1;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexScale;True;False;Cylindrical;False;Relative;0;Standard;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;183;0;181;0
WireConnection;186;0;183;0
WireConnection;187;0;184;0
WireConnection;191;0;183;0
WireConnection;190;0;186;0
WireConnection;190;1;186;1
WireConnection;192;0;191;0
WireConnection;192;1;191;1
WireConnection;192;2;191;2
WireConnection;194;0;190;0
WireConnection;194;1;186;2
WireConnection;193;0;187;0
WireConnection;193;3;189;0
WireConnection;193;4;188;0
WireConnection;195;0;191;1
WireConnection;195;1;192;0
WireConnection;196;0;194;0
WireConnection;196;1;193;0
WireConnection;198;0;191;2
WireConnection;198;1;192;0
WireConnection;197;0;191;0
WireConnection;197;1;192;0
WireConnection;199;0;197;0
WireConnection;199;1;195;0
WireConnection;199;2;198;0
WireConnection;200;0;194;0
WireConnection;200;1;196;0
WireConnection;201;0;199;0
WireConnection;201;1;200;0
WireConnection;202;0;201;0
WireConnection;203;0;202;0
WireConnection;209;0;206;0
WireConnection;209;2;208;0
WireConnection;211;0;207;0
WireConnection;212;0;209;0
WireConnection;212;1;210;1
WireConnection;212;2;210;2
WireConnection;213;0;211;0
WireConnection;213;1;211;1
WireConnection;214;0;213;0
WireConnection;214;1;211;2
WireConnection;215;1;212;0
WireConnection;218;0;215;0
WireConnection;217;0;216;0
WireConnection;217;1;214;0
WireConnection;219;0;217;0
WireConnection;219;1;207;0
WireConnection;224;0;214;0
WireConnection;224;1;216;0
WireConnection;224;4;219;0
WireConnection;223;0;220;0
WireConnection;226;0;224;0
WireConnection;225;0;223;3
WireConnection;225;1;221;0
WireConnection;225;2;222;0
WireConnection;229;0;225;0
WireConnection;230;0;229;0
WireConnection;230;1;229;1
WireConnection;231;0;228;0
WireConnection;231;1;227;0
WireConnection;235;0;231;0
WireConnection;235;1;232;0
WireConnection;235;2;220;0
WireConnection;233;0;230;0
WireConnection;233;1;229;2
WireConnection;0;2;235;0
WireConnection;0;9;233;0
ASEEND*/
//CHKSM=4EE56DB20B23860FB03645BBFCABEF388CA36C82