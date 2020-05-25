// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BlackScreenChromaHologram"
{
	Properties
	{
		_RenderTexture1("RenderTexture", 2D) = "white" {}
		_HologramTex1("HologramTex", 2D) = "white" {}
		_HologramColor1("HologramColor", Color) = (1,1,1,1)
		_HologramStrength1("HologramStrength", Range( 0 , 10)) = 1
		_HologramScroll1("HologramScroll", Vector) = (-0.02,0,0,0)
		_PixelateUVsXY1("PixelateUVsXY", Vector) = (420,69,0,0)
		[Toggle(_BRIGHTEN1_ON)] _Brighten1("Brighten", Float) = 1
		_Brightness1("Brightness", Range( 0 , 1)) = 0.5
		_MinBrightness1("MinBrightness", Range( 0 , 1)) = 0.2
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
		#pragma shader_feature _BRIGHTEN1_ON
		#pragma surface surf Standard alpha:fade keepalpha noshadow exclude_path:deferred noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _RenderTexture1;
		uniform float4 _RenderTexture1_ST;
		uniform float _Brightness1;
		uniform float _MinBrightness1;
		uniform float4 _HologramColor1;
		uniform sampler2D _HologramTex1;
		uniform float2 _HologramScroll1;
		uniform float2 _PixelateUVsXY1;
		uniform float _HologramStrength1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_RenderTexture1 = i.uv_texcoord * _RenderTexture1_ST.xy + _RenderTexture1_ST.zw;
			float4 inputTexture259 = tex2D( _RenderTexture1, uv_RenderTexture1 );
			float4 break263 = inputTexture259;
			float temp_output_268_0 = ( break263.r + break263.g + break263.b );
			float4 appendResult276 = (float4(( break263.r / temp_output_268_0 ) , ( break263.g / temp_output_268_0 ) , ( break263.b / temp_output_268_0 ) , 0.0));
			float4 break262 = inputTexture259;
			float temp_output_270_0 = max( max( break262.r , break262.g ) , break262.b );
			float4 BrightenedChromaContent282 = saturate( ( appendResult276 * ( temp_output_270_0 / ( temp_output_270_0 + (0.0001 + (( 1.0 - _Brightness1 ) - 0.0) * (0.1 - 0.0001) / (1.0 - 0.0)) ) ) ) );
			float4 break288 = BrightenedChromaContent282;
			float temp_output_293_0 = max( max( break288.x , break288.y ) , break288.z );
			float4 ifLocalVar302 = 0;
			if( temp_output_293_0 < _MinBrightness1 )
				ifLocalVar302 = ( ( _MinBrightness1 - temp_output_293_0 ) + BrightenedChromaContent282 );
			float4 BrightBoost303 = ifLocalVar302;
			#ifdef _BRIGHTEN1_ON
				float4 staticSwitch312 = ( BrightBoost303 + BrightenedChromaContent282 );
			#else
				float4 staticSwitch312 = inputTexture259;
			#endif
			float2 panner286 = ( 1.0 * _Time.y * _HologramScroll1 + i.uv_texcoord);
			float pixelWidth287 =  1.0f / _PixelateUVsXY1.x;
			float pixelHeight287 = 1.0f / _PixelateUVsXY1.y;
			half2 pixelateduv287 = half2((int)(panner286.x / pixelWidth287) * pixelWidth287, (int)(panner286.y / pixelHeight287) * pixelHeight287);
			float4 Hologram292 = tex2D( _HologramTex1, pixelateduv287 );
			o.Emission = ( staticSwitch312 * _HologramColor1 * Hologram292 ).rgb;
			float4 break301 = ( Hologram292.a * inputTexture259 * _HologramStrength1 );
			float clampResult308 = clamp( max( max( break301.r , break301.g ) , break301.b ) , 0.0 , 1.0 );
			float FinalOpacity313 = clampResult308;
			o.Alpha = FinalOpacity313;
		}

		ENDCG
	}
	Fallback "Standard"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18000
1927;8;1906;978;2008.056;927.9489;1;True;False
Node;AmplifyShaderEditor.SamplerNode;257;-3871.169,-722.9272;Inherit;True;Property;_RenderTexture1;RenderTexture;0;0;Create;True;0;0;False;0;-1;088a4ead21b5e9744b41b802e259ad48;088a4ead21b5e9744b41b802e259ad48;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;259;-3563.292,-724.042;Inherit;False;inputTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;258;-3345.174,-627.3545;Inherit;False;1192.631;456.9985;Find max of RGB to determine brightness(B). Read Sensitivity(S) :: B/(B+S) grows quickly at low values and slows as it approaches 1.0;10;275;273;270;269;267;266;265;264;262;260;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;262;-3032.469,-568.1465;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;260;-3285.732,-429.1129;Float;False;Property;_Brightness1;Brightness;7;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;261;-3343.331,-1059.835;Inherit;False;1068.602;424.0002;Normalize Colors to be brighter based on ratio of R/G/B;6;276;274;272;271;268;263;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-2974.543,-269.356;Inherit;False;Constant;_BrightnessMax1;BrightnessMax;10;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;263;-3068.766,-851.9438;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;264;-2972.543,-339.3558;Inherit;False;Constant;_BrightnessMin1;BrightnessMin;10;0;Create;True;0;0;False;0;0.0001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;265;-2769.923,-577.3545;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;266;-2875.923,-422.7772;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;270;-2645.123,-547.4546;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;269;-2688.543,-422.3561;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;268;-2779.725,-1009.835;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;274;-2605.526,-869.4347;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;273;-2475.543,-449.3561;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;272;-2605.527,-956.5353;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;271;-2605.526,-783.6343;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;276;-2438.729,-911.0347;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;275;-2348.543,-518.356;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;277;-2086.826,-746.5234;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;278;-1551.659,-1560.082;Inherit;False;1256.741;428.0046;Generate Hologram Modifier;7;292;290;287;286;285;283;280;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;279;-1890.438,-747.2646;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;281;-3564.392,-1614.653;Inherit;False;1873.572;489.3113;Set a Minimum Brightness for any portions of the brightened content whos max RGB values are below a threshold, preserving original color values.;9;303;302;299;296;293;291;289;288;284;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;283;-1535.659,-1401.082;Float;False;Property;_HologramScroll1;HologramScroll;4;0;Create;True;0;0;False;0;-0.02,0;0,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;282;-1752.535,-751.2036;Inherit;True;BrightenedChromaContent;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;280;-1539.659,-1515.082;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;286;-1321.659,-1451.082;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;285;-1533.649,-1278.077;Float;False;Property;_PixelateUVsXY1;PixelateUVsXY;5;0;Create;True;0;0;False;0;420,69;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;284;-3512.392,-1365.695;Inherit;True;282;BrightenedChromaContent;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;288;-3155.676,-1463.169;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TFHCPixelate;287;-1151.658,-1272.081;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1024;False;2;FLOAT;1024;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;289;-2899.129,-1459.377;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;290;-980.8055,-1483.325;Inherit;True;Property;_HologramTex1;HologramTex;1;0;Create;True;0;0;False;0;-1;bfe4769db15cb2940b1d758cc8406bc4;bfe4769db15cb2940b1d758cc8406bc4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;291;-3016.052,-1564.653;Inherit;False;Property;_MinBrightness1;MinBrightness;8;0;Create;True;0;0;False;0;0.2;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;292;-592.3224,-1473.304;Float;False;Hologram;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;293;-2781.329,-1416.477;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;294;-264.2797,-1618.937;Inherit;False;1130.711;577.4425;Use Hologram image with user settings to calculate final Opacity;9;313;308;307;304;301;300;298;297;295;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;297;-212.4628,-1234.937;Inherit;False;Property;_HologramStrength1;HologramStrength;3;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;295;-174.2339,-1430.5;Inherit;True;259;inputTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;296;-2660.044,-1496.341;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;298;-187.4628,-1568.937;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;300;86.99229,-1454.311;Inherit;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;299;-2519.044,-1378.341;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;301;298.4319,-1494.901;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ConditionalIfNode;302;-2225.044,-1561.341;Inherit;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;304;541.4315,-1531.901;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;303;-1975.819,-1565.067;Inherit;True;BrightBoost;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;306;-1410.174,-627.5688;Inherit;False;282;BrightenedChromaContent;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;305;-1357.102,-697.0774;Inherit;False;303;BrightBoost;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;307;664.4315,-1519.901;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;309;-1107.638,-666.4429;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;310;-1100.498,-749.6553;Inherit;False;259;inputTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;308;476.1901,-1280.384;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;312;-877.6495,-697.4783;Inherit;False;Property;_Brighten1;Brighten;6;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;313;645.278,-1275.9;Float;True;FinalOpacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;311;-873.9459,-579.1421;Float;False;Property;_HologramColor1;HologramColor;2;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;314;-874.4008,-404.9703;Inherit;True;292;Hologram;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;315;-274.6025,-465.3536;Inherit;False;Constant;_Int1;Int 0;8;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;317;-355.226,-325.5287;Inherit;True;313;FinalOpacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;316;-575.4003,-592.9705;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-44.6086,-639.0496;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;BlackScreenChromaHologram;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;1;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;1;5;False;-1;5;False;-1;1;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexScale;True;False;Cylindrical;False;Relative;0;Standard;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;259;0;257;0
WireConnection;262;0;259;0
WireConnection;263;0;259;0
WireConnection;265;0;262;0
WireConnection;265;1;262;1
WireConnection;266;0;260;0
WireConnection;270;0;265;0
WireConnection;270;1;262;2
WireConnection;269;0;266;0
WireConnection;269;3;264;0
WireConnection;269;4;267;0
WireConnection;268;0;263;0
WireConnection;268;1;263;1
WireConnection;268;2;263;2
WireConnection;274;0;263;1
WireConnection;274;1;268;0
WireConnection;273;0;270;0
WireConnection;273;1;269;0
WireConnection;272;0;263;0
WireConnection;272;1;268;0
WireConnection;271;0;263;2
WireConnection;271;1;268;0
WireConnection;276;0;272;0
WireConnection;276;1;274;0
WireConnection;276;2;271;0
WireConnection;275;0;270;0
WireConnection;275;1;273;0
WireConnection;277;0;276;0
WireConnection;277;1;275;0
WireConnection;279;0;277;0
WireConnection;282;0;279;0
WireConnection;286;0;280;0
WireConnection;286;2;283;0
WireConnection;288;0;284;0
WireConnection;287;0;286;0
WireConnection;287;1;285;1
WireConnection;287;2;285;2
WireConnection;289;0;288;0
WireConnection;289;1;288;1
WireConnection;290;1;287;0
WireConnection;292;0;290;0
WireConnection;293;0;289;0
WireConnection;293;1;288;2
WireConnection;296;0;291;0
WireConnection;296;1;293;0
WireConnection;298;0;292;0
WireConnection;300;0;298;3
WireConnection;300;1;295;0
WireConnection;300;2;297;0
WireConnection;299;0;296;0
WireConnection;299;1;284;0
WireConnection;301;0;300;0
WireConnection;302;0;293;0
WireConnection;302;1;291;0
WireConnection;302;4;299;0
WireConnection;304;0;301;0
WireConnection;304;1;301;1
WireConnection;303;0;302;0
WireConnection;307;0;304;0
WireConnection;307;1;301;2
WireConnection;309;0;305;0
WireConnection;309;1;306;0
WireConnection;308;0;307;0
WireConnection;312;1;310;0
WireConnection;312;0;309;0
WireConnection;313;0;308;0
WireConnection;316;0;312;0
WireConnection;316;1;311;0
WireConnection;316;2;314;0
WireConnection;0;2;316;0
WireConnection;0;9;317;0
ASEEND*/
//CHKSM=DBC08028FDDDCDDBF025337E62EF07A65144B5B5