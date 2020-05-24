// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ChromaTest"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Color0("Color 0", Color) = (0,1,0,1)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Sensitivity("Sensitivity", Range( 0 , 1)) = 0
		_Smoothing("Smoothing", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Sensitivity;
		uniform float _Smoothing;
		uniform float4 _Color0;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float temp_output_307_0 = ( ( ( 0.298 * _Color0.r ) + ( 0.586 * _Color0.g ) ) + ( 0.114 * _Color0.b ) );
			float2 appendResult326 = (float2(( 0.713 * ( _Color0.r - temp_output_307_0 ) ) , ( 0.564 * ( _Color0.b - temp_output_307_0 ) )));
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode282 = tex2D( _TextureSample0, uv_TextureSample0 );
			float temp_output_316_0 = ( ( ( 0.298 * tex2DNode282.r ) + ( 0.586 * tex2DNode282.g ) ) + ( 0.114 * tex2DNode282.b ) );
			float2 appendResult327 = (float2(( ( tex2DNode282.r - temp_output_316_0 ) * 0.713 ) , ( ( tex2DNode282.b - temp_output_316_0 ) * 0.564 )));
			float smoothstepResult330 = smoothstep( _Sensitivity , ( _Sensitivity + _Smoothing ) , distance( appendResult326 , appendResult327 ));
			o.Albedo = ( smoothstepResult330 * tex2DNode282 ).rgb;
			o.Alpha = 1;
			clip( smoothstepResult330 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15001
1351;149;1158;855;2156.473;689.4933;2.109496;True;False
Node;AmplifyShaderEditor.ColorNode;281;-1408,128;Float;False;Property;_Color0;Color 0;1;0;Create;True;0;0;False;0;0,1,0,1;0,1,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;282;-1408,384;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;44af869ad019f9543ba5d0844d83632b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;298;-1408,-256;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.298;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;299;-1408,-192;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;0.586;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;313;-1024,512;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;304;-1024,-128;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;300;-1408,-128;Float;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;False;0;0.114;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;312;-1024,386;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;303;-1024,-256;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;314;-1024,640;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;315;-768,432;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;306;-768,-208;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;305;-1024,0;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;316;-768,560;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;307;-768,-80;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;301;-1408,-64;Float;False;Constant;_Float3;Float 3;3;0;Create;True;0;0;False;0;0.713;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;317;-512,384;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;318;-512,512;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;302;-1408,0;Float;False;Constant;_Float4;Float 4;3;0;Create;True;0;0;False;0;0.564;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;309;-512,128;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;308;-512,0;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;321;-256,384;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;310;-256,0;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;311;-256,128;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;322;-256,512;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;332;-72.90668,-149.4352;Float;False;Property;_Smoothing;Smoothing;4;0;Create;True;0;0;False;0;0;0.12;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;331;26.29327,-255.0352;Float;False;Property;_Sensitivity;Sensitivity;3;0;Create;True;0;0;False;0;0;0.43;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;326;0,0;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;327;0,384;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;333;298.2933,26.56477;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;329;167.8933,204.1647;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;330;492.6933,4.164767;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;560.6933,312.9647;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;3;865.7001,22.2;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ChromaTest;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;0;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;313;0;299;0
WireConnection;313;1;282;2
WireConnection;304;0;299;0
WireConnection;304;1;281;2
WireConnection;312;0;298;0
WireConnection;312;1;282;1
WireConnection;303;0;298;0
WireConnection;303;1;281;1
WireConnection;314;0;300;0
WireConnection;314;1;282;3
WireConnection;315;0;312;0
WireConnection;315;1;313;0
WireConnection;306;0;303;0
WireConnection;306;1;304;0
WireConnection;305;0;300;0
WireConnection;305;1;281;3
WireConnection;316;0;315;0
WireConnection;316;1;314;0
WireConnection;307;0;306;0
WireConnection;307;1;305;0
WireConnection;317;0;282;1
WireConnection;317;1;316;0
WireConnection;318;0;282;3
WireConnection;318;1;316;0
WireConnection;309;0;281;3
WireConnection;309;1;307;0
WireConnection;308;0;281;1
WireConnection;308;1;307;0
WireConnection;321;0;317;0
WireConnection;321;1;301;0
WireConnection;310;0;301;0
WireConnection;310;1;308;0
WireConnection;311;0;302;0
WireConnection;311;1;309;0
WireConnection;322;0;318;0
WireConnection;322;1;302;0
WireConnection;326;0;310;0
WireConnection;326;1;311;0
WireConnection;327;0;321;0
WireConnection;327;1;322;0
WireConnection;333;0;331;0
WireConnection;333;1;332;0
WireConnection;329;0;326;0
WireConnection;329;1;327;0
WireConnection;330;0;329;0
WireConnection;330;1;331;0
WireConnection;330;2;333;0
WireConnection;334;0;330;0
WireConnection;334;1;282;0
WireConnection;3;0;334;0
WireConnection;3;10;330;0
ASEEND*/
//CHKSM=67A21ACDAF10AB140D7F05451B3E12BE8A8D90E9