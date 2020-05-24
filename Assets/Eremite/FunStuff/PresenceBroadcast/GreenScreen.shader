// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Eremite/Greenscreen"
{
	Properties
	{
		_RenderTex("RenderTex", 2D) = "white" {}
		_ChromaKey("ChromaKey", Color) = (0,0,0,0)
		_MaskClipValue("MaskClipValue", Range( 0 , 1)) = 0.3
		_Smoothing("Smoothing", Range( 0 , 1)) = 0
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
			float OpacityMask72 = max( max( abs( ( texRed10 - chromaRed15 ) ) , abs( ( texGreen11 - chromaGreen14 ) ) ) , abs( ( texBlue12 - chromaBlue13 ) ) );
			float smoothing76 = ( (0.0 + (_Smoothing - 0.0) * (( 1.0 - _MaskClipValue ) - 0.0) / (1.0 - 0.0)) + _MaskClipValue );
			o.Emission = ( appendResult32 - ( chromaRGB44 * step( OpacityMask72 , smoothing76 ) ) ).xyz;
			o.Alpha = 1;
			clip( OpacityMask72 - _MaskClipValue );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15600
1920;2;1906;1008;1881.559;238.5945;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-1366.855,-75.1338;Float;True;Property;_RenderTex;RenderTex;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;75;-2589.158,694.6602;Float;False;1036.797;544.3142;Generate Opacity Mask By Finding Max Difference From ChromaKey;15;17;20;21;22;24;25;19;23;18;26;47;27;16;48;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;9;-1086.227,-69.88272;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;2;-2044.627,-386.8727;Float;False;Property;_ChromaKey;ChromaKey;1;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-1798.408,-342.2632;Float;False;chromaGreen;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-1799.408,-409.2632;Float;False;chromaRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-2539.158,973.6608;Float;False;14;chromaGreen;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;17;-2524.158,814.6606;Float;False;15;chromaRed;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-841.2277,-118.8829;Float;False;texRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-840.2277,-51.88274;Float;False;texGreen;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-2504.158,744.6603;Float;False;10;texRed;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;78;-2610.328,314.3664;Float;False;1087.025;349.4005;Find Smoothing Value, ramap so clip doesn't go above 1.0;6;71;7;6;70;46;76;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-2513.158,898.6607;Float;False;11;texGreen;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-840.2277,17.11737;Float;False;texBlue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-1798.408,-273.2631;Float;False;chromaBlue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;24;-2511.905,1051.975;Float;False;12;texBlue;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;19;-2330.158,769.6604;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-2531.905,1123.975;Float;False;13;chromaBlue;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-2329.158,927.6607;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2560.328,548.7667;Float;False;Property;_MaskClipValue;MaskClipValue;2;0;Create;True;0;0;False;0;0.3;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-2334.905,1074.975;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;18;-2192.157,771.6604;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;70;-2282.766,503.6971;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-2385.427,364.3663;Float;False;Property;_Smoothing;Smoothing;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;23;-2194.158,930.6607;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;71;-2096.766,407.6971;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;27;-2193.905,1074.975;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;47;-2071.783,840.009;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-1898.77,527.8092;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;48;-1950.201,940.2624;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;74;-1010.259,225.9942;Float;False;72;OpacityMask;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;77;-1007.148,304.3868;Float;False;76;smoothing;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;76;-1766.301,522.3025;Float;False;smoothing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;72;-1795.361,939.8087;Float;False;OpacityMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;43;-791.3019,243.2979;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-766.424,147.9031;Float;False;44;chromaRGB;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-1798.24,-482.634;Float;False;chromaRGB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;32;-608.9038,-69.10175;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-510.8041,155.3977;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;39;-231.9039,37.59791;Float;False;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-224.1351,306.1351;Float;False;72;OpacityMask;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,-13;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Eremite/Greenscreen;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;Back;1;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexScale;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;6;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;1;0
WireConnection;14;0;2;2
WireConnection;15;0;2;1
WireConnection;10;0;9;0
WireConnection;11;0;9;1
WireConnection;12;0;9;2
WireConnection;13;0;2;3
WireConnection;19;0;16;0
WireConnection;19;1;17;0
WireConnection;22;0;21;0
WireConnection;22;1;20;0
WireConnection;26;0;24;0
WireConnection;26;1;25;0
WireConnection;18;0;19;0
WireConnection;70;0;6;0
WireConnection;23;0;22;0
WireConnection;71;0;7;0
WireConnection;71;4;70;0
WireConnection;27;0;26;0
WireConnection;47;0;18;0
WireConnection;47;1;23;0
WireConnection;46;0;71;0
WireConnection;46;1;6;0
WireConnection;48;0;47;0
WireConnection;48;1;27;0
WireConnection;76;0;46;0
WireConnection;72;0;48;0
WireConnection;43;0;74;0
WireConnection;43;1;77;0
WireConnection;44;0;2;0
WireConnection;32;0;10;0
WireConnection;32;1;11;0
WireConnection;32;2;12;0
WireConnection;40;0;45;0
WireConnection;40;1;43;0
WireConnection;39;0;32;0
WireConnection;39;1;40;0
WireConnection;0;2;39;0
WireConnection;0;10;73;0
ASEEND*/
//CHKSM=0EC029936BDE22CFB666C5CAFCC896DB527AC317