// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Eremite/Greenscreen"
{
	Properties
	{
		_RenderTex("RenderTex", 2D) = "white" {}
		_ChromaKey("ChromaKey", Color) = (0,0,0,0)
		_MaskClipValue("MaskClipValue", Range( 0 , 1)) = 0.3
		_Smoothing("Smoothing", Range( 0 , 1)) = 0.25
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow exclude_path:deferred noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _RenderTex;
		uniform float4 _RenderTex_ST;
		uniform float4 _ChromaKey;
		uniform float _Smoothing;
		uniform float _MaskClipValue;

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
			float temp_output_29_0 = ( ( abs( ( texRed10 - chromaRed15 ) ) + abs( ( texGreen11 - chromaGreen14 ) ) + abs( ( texBlue12 - chromaBlue13 ) ) ) / 3 );
			o.Emission = ( appendResult32 - ( chromaRGB44 * step( temp_output_29_0 , _Smoothing ) ) ).xyz;
			o.Alpha = 1;
			clip( temp_output_29_0 - _MaskClipValue );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15600
1920;2;1906;1008;2078.808;354.9832;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-1366.855,-75.1338;Float;True;Property;_RenderTex;RenderTex;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;9;-1086.227,-69.88272;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;2;-816.1,-356.4001;Float;False;Property;_ChromaKey;ChromaKey;1;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-841.2277,-118.8829;Float;False;texRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-840.2277,-51.88274;Float;False;texGreen;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-840.2277,17.11737;Float;False;texBlue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-569.8822,-311.7906;Float;False;chromaGreen;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-1260.191,267.4453;Float;False;10;texRed;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-569.8822,-242.7905;Float;False;chromaBlue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-1295.191,496.4454;Float;False;14;chromaGreen;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;17;-1280.191,337.4453;Float;False;15;chromaRed;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-1287.938,646.7593;Float;False;13;chromaBlue;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;24;-1267.938,574.7593;Float;False;12;texBlue;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-1269.191,421.4453;Float;False;11;texGreen;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-570.8822,-378.7906;Float;False;chromaRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-1090.938,597.7593;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-1085.191,450.4453;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;19;-1086.191,292.4452;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;18;-948.1909,294.4452;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;27;-949.9379,597.7593;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;23;-950.191,453.4453;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-794.9374,430.759;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;30;-796.9374,552.7592;Float;False;Constant;_Int0;Int 0;5;0;Create;True;0;0;False;0;3;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-797.4728,285.3507;Float;False;Property;_Smoothing;Smoothing;3;0;Create;True;0;0;False;0;0.25;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;29;-638.9377,429.759;Float;False;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-621.424,167.9031;Float;False;44;chromaRGB;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-572.3213,-475.6302;Float;False;chromaRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;43;-517.3019,243.2979;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;32;-608.9038,-69.10175;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-365.8041,175.3977;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1642.373,196.751;Float;False;Property;_MaskClipValue;MaskClipValue;2;0;Create;True;0;0;False;0;0.3;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;31;-332.7525,-233.9346;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;39;-231.9039,37.59791;Float;False;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,-13;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Eremite/Greenscreen;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;Back;1;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexScale;True;False;Cylindrical;False;Relative;0;;0;2;-1;-1;0;False;0;0;False;-1;-1;0;True;6;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;1;0
WireConnection;10;0;9;0
WireConnection;11;0;9;1
WireConnection;12;0;9;2
WireConnection;14;0;2;2
WireConnection;13;0;2;3
WireConnection;15;0;2;1
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;22;0;21;0
WireConnection;22;1;20;0
WireConnection;19;0;16;0
WireConnection;19;1;17;0
WireConnection;18;0;19;0
WireConnection;27;0;26;0
WireConnection;23;0;22;0
WireConnection;28;0;18;0
WireConnection;28;1;23;0
WireConnection;28;2;27;0
WireConnection;29;0;28;0
WireConnection;29;1;30;0
WireConnection;44;0;2;0
WireConnection;43;0;29;0
WireConnection;43;1;7;0
WireConnection;32;0;10;0
WireConnection;32;1;11;0
WireConnection;32;2;12;0
WireConnection;40;0;45;0
WireConnection;40;1;43;0
WireConnection;39;0;32;0
WireConnection;39;1;40;0
WireConnection;0;2;39;0
WireConnection;0;10;29;0
ASEEND*/
//CHKSM=BCDE7F7EDA7825219183E265E2BD33CFD596FBE4