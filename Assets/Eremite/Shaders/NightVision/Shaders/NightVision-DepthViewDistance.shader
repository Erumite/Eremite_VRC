// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Eremite/NightVision-DepthViewDistance"
{
	Properties
	{
		_Sensitivity("Sensitivity", Range( 0 , 1)) = 0.9
		_Color("Color", Color) = (1,1,1,0)
		_ViewDist("ViewDist", Int) = 50
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		ZTest LEqual
		GrabPass{ }
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			half ASEVFace : VFACE;
			float4 screenPos;
		};

		uniform sampler2D _GrabTexture;
		uniform float _Sensitivity;
		uniform float4 _Color;
		uniform sampler2D _CameraDepthTexture;
		uniform int _ViewDist;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float clampResult44 = clamp( i.ASEVFace , 0.0 , 1.0 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 screenColor2 = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD( ase_grabScreenPos ) );
			float4 ScreenColor47 = screenColor2;
			float4 break51 = ScreenColor47;
			float temp_output_3_0 = ( break51.r + break51.g + break51.b );
			float4 appendResult9 = (float4(( break51.r / temp_output_3_0 ) , ( break51.g / temp_output_3_0 ) , ( break51.b / temp_output_3_0 ) , 0.0));
			float4 break53 = ScreenColor47;
			float temp_output_11_0 = max( max( break53.r , break53.g ) , break53.b );
			float clampResult43 = clamp( i.ASEVFace , 0.0 , 1.0 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float clampDepth58 = Linear01Depth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPosNorm ))));
			float clampResult72 = clamp( (0.0 + (clampDepth58 - 0.0) * (1000.0 - 0.0) / (1.0 - 0.0)) , 0.0 , (float)_ViewDist );
			o.Emission = saturate( ( ( ( 1.0 - clampResult44 ) * ScreenColor47 ) + ( appendResult9 * ( temp_output_11_0 / ( temp_output_11_0 + (0.0001 + (( 1.0 - _Sensitivity ) - 0.0) * (0.1 - 0.0001) / (1.0 - 0.0)) ) ) * _Color * clampResult43 * ( 1.0 - (0.0 + (clampResult72 - 0.0) * (1.0 - 0.0) / ((float)_ViewDist - 0.0)) ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Standard"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15600
1927;32;1906;1014;2886.106;-222.6679;1.7141;True;False
Node;AmplifyShaderEditor.ScreenColorNode;2;-1772.279,-273.4962;Float;False;Global;_GrabScreen0;Grab Screen 0;0;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;56;-2157.699,520.0563;Float;False;1178.343;502.4994;Find Max of RGB to determine brightness(B). Read Sensitivity(S) :: B/(B+S) grows quickly at low values and slows as it approaches 1.;9;52;53;12;10;18;11;14;13;17;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;74;-1680.325,1082.893;Float;False;1200.092;331.4434;Read Depth Buffer to set an effective view distance.;7;57;58;71;67;72;73;59;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;54;-1894.74,37.86856;Float;False;1016.768;446.2584;Generate Output Color by R/G/B Ratio C/(R+G+B);7;3;8;7;6;9;51;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;57;-1630.325,1133.308;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;47;-1571.644,-274.4918;Float;False;ScreenColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;-2107.699,577.8564;Float;False;47;ScreenColor;0;1;COLOR;0
Node;AmplifyShaderEditor.ScreenDepthNode;58;-1420.071,1132.893;Float;False;1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-1844.741,189.9854;Float;False;47;ScreenColor;0;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1930.35,764.5557;Float;True;Property;_Sensitivity;Sensitivity;1;0;Create;True;0;0;False;0;0.9;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;53;-1903.711,582.9906;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TFHCRemapNode;71;-1210.423,1136.005;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1000;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;18;-1652.197,769.11;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;10;-1625.534,570.0563;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;51;-1648.829,195.4721;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;49;-1210.636,-331.3484;Float;False;670.6923;282.9296;Nullify Screen Color for FrontFaces;5;44;36;39;35;48;;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;67;-1198.813,1299.337;Float;False;Property;_ViewDist;ViewDist;3;0;Create;True;0;0;False;0;50;0;0;1;INT;0
Node;AmplifyShaderEditor.FaceVariableNode;36;-1160.636,-281.3483;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-1390.49,87.86859;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;11;-1487.15,633.1526;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;17;-1467.217,767.4226;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.0001;False;4;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;72;-1017.424,1136.005;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;55;-919.134,652.6516;Float;False;354.923;206;Nulify This All for BackFaces;2;34;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-1261.526,707.6785;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;8;-1208.973,351.127;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;44;-1036.385,-281.1953;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;7;-1209.973,259.1269;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;6;-1210.973,169.127;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;73;-849.4233,1136.005;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FaceVariableNode;34;-869.134,702.9469;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;13;-1136.356,634.3572;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;-1030.859,-163.4187;Float;False;47;ScreenColor;0;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;59;-667.2339,1135.713;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;-656.6528,311.7054;Float;False;Property;_Color;Color;2;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;43;-739.2111,702.6516;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;9;-1044.973,192.127;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;39;-894.8708,-280.208;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-708.9439,-252.2331;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-335.9165,174.325;Float;False;5;5;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-184.8792,14.54053;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;33;-43.55066,14.02979;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;109.7294,-29.75713;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Eremite/NightVision-DepthViewDistance;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;Off;2;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;3;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;1;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;1;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;Standard;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;47;0;2;0
WireConnection;58;0;57;0
WireConnection;53;0;52;0
WireConnection;71;0;58;0
WireConnection;18;0;12;0
WireConnection;10;0;53;0
WireConnection;10;1;53;1
WireConnection;51;0;50;0
WireConnection;3;0;51;0
WireConnection;3;1;51;1
WireConnection;3;2;51;2
WireConnection;11;0;10;0
WireConnection;11;1;53;2
WireConnection;17;0;18;0
WireConnection;72;0;71;0
WireConnection;72;2;67;0
WireConnection;14;0;11;0
WireConnection;14;1;17;0
WireConnection;8;0;51;2
WireConnection;8;1;3;0
WireConnection;44;0;36;0
WireConnection;7;0;51;1
WireConnection;7;1;3;0
WireConnection;6;0;51;0
WireConnection;6;1;3;0
WireConnection;73;0;72;0
WireConnection;73;2;67;0
WireConnection;13;0;11;0
WireConnection;13;1;14;0
WireConnection;59;0;73;0
WireConnection;43;0;34;0
WireConnection;9;0;6;0
WireConnection;9;1;7;0
WireConnection;9;2;8;0
WireConnection;39;0;44;0
WireConnection;35;0;39;0
WireConnection;35;1;48;0
WireConnection;15;0;9;0
WireConnection;15;1;13;0
WireConnection;15;2;19;0
WireConnection;15;3;43;0
WireConnection;15;4;59;0
WireConnection;37;0;35;0
WireConnection;37;1;15;0
WireConnection;33;0;37;0
WireConnection;0;2;33;0
ASEEND*/
//CHKSM=D264D72C4783CFB4EA09B75F9BD8D1280EA78681