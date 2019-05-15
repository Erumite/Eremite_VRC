// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASETemplateShaders/Unlit"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Texture("Texture", 2D) = "white" {}
		_EmissionLevel("EmissionLevel", Int) = 1
		_TilingY2("TilingY2", Int) = 5
		_TilingY("TilingY", Int) = 10
		_TilingX2("TilingX2", Int) = 5
		_TilingX("TilingX", Int) = 10
		_Speed1("Speed1", Float) = -0.5
		_Color("Color", Color) = (1,1,1,0)
		_Speed2("Speed2", Float) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Speed1;
		uniform int _TilingX;
		uniform int _TilingY;
		uniform float _Speed2;
		uniform int _TilingX2;
		uniform int _TilingY2;
		uniform int _EmissionLevel;
		uniform float4 _Color;
		uniform sampler2D _Texture;
		uniform float4 _Texture_ST;
		uniform float _Cutoff = 0.5;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_cast_0 = (_Speed1).xx;
			float4 appendResult14 = (float4(( _TilingX + _SinTime.z ) , ( _SinTime.z + _TilingY ) , 0.0 , 0.0));
			float2 uv_TexCoord4 = i.uv_texcoord * appendResult14.xy;
			float2 panner36 = ( 1.0 * _Time.y * temp_cast_0 + uv_TexCoord4);
			float simplePerlin2D3 = snoise( panner36 );
			float2 temp_cast_2 = (_Speed2).xx;
			float4 appendResult21 = (float4(( _TilingX2 + _SinTime.z ) , ( _SinTime.z + _TilingY2 ) , 0.0 , 0.0));
			float2 uv_TexCoord22 = i.uv_texcoord * appendResult21.xy;
			float2 panner39 = ( 1.0 * _Time.y * temp_cast_2 + uv_TexCoord22);
			float simplePerlin2D23 = snoise( panner39 );
			float2 uv_Texture = i.uv_texcoord * _Texture_ST.xy + _Texture_ST.zw;
			float4 tex2DNode2 = tex2D( _Texture, uv_Texture );
			float4 temp_output_12_0 = ( simplePerlin2D3 * ( simplePerlin2D3 * simplePerlin2D23 ) * _EmissionLevel * _Color * tex2DNode2 );
			o.Emission = temp_output_12_0.rgb;
			o.Alpha = 1;
			float4 break49 = temp_output_12_0;
			clip( min( max( max( max( break49.r , break49.g ) , break49.b ) , break49.a ) , tex2DNode2.a ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15600
1440;204;1891;932;404.7169;358.9401;1;False;False
Node;AmplifyShaderEditor.IntNode;31;-1781.37,-166.735;Float;False;Property;_TilingX2;TilingX2;7;0;Create;True;0;0;False;0;5;0;0;1;INT;0
Node;AmplifyShaderEditor.SinTimeNode;9;-1709.695,-548.0297;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;30;-1782.671,62.09691;Float;False;Property;_TilingY2;TilingY2;5;0;Create;True;0;0;False;0;5;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;28;-1710.302,-635.1784;Float;False;Property;_TilingX;TilingX;8;0;Create;True;0;0;False;0;10;0;0;1;INT;0
Node;AmplifyShaderEditor.SinTimeNode;32;-1780.764,-79.58582;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;29;-1711.602,-406.3476;Float;False;Property;_TilingY;TilingY;6;0;Create;True;0;0;False;0;10;0;0;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-1529.578,-607.8751;Float;False;2;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-1532.177,-463.5552;Float;False;2;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-1600.646,-139.4316;Float;False;2;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-1603.246,4.889271;Float;False;2;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;-1309.467,-522.9237;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;21;-1449.61,-83.22856;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-1130.173,-264.0633;Float;False;Property;_Speed1;Speed1;9;0;Create;True;0;0;False;0;-0.5;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-1138.173,21.93671;Float;False;Property;_Speed2;Speed2;9;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-1285.401,-105.3986;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1165.399,-545.5636;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;39;-933.814,-105.649;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;36;-902.7267,-502.9134;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;3;-709.5305,-536.5663;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;23;-685.7581,-88.60998;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;57;-441.6355,-26.2044;Float;False;Property;_Color;Color;9;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;25;-434.5454,-101.449;Float;False;Property;_EmissionLevel;EmissionLevel;2;0;Create;True;0;0;False;0;1;1;0;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;2;-464.9522,146.8973;Float;True;Property;_Texture;Texture;1;0;Create;True;0;0;False;0;e4582fa1d3a4bd34fa462db7dce10db9;e4582fa1d3a4bd34fa462db7dce10db9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-427.5683,-204.035;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-50.5425,-218.2707;Float;True;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;INT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;49;188.7147,-71.52383;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMaxOpNode;52;433.9353,-71.05699;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;53;554.3404,-46.99881;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;58;678.8268,-3.063293;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;54;799.7687,84.05035;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1;948.4007,-260.4899;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;ASETemplateShaders/Unlit;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;26;0;28;0
WireConnection;26;1;9;3
WireConnection;27;0;9;3
WireConnection;27;1;29;0
WireConnection;34;0;31;0
WireConnection;34;1;32;3
WireConnection;33;0;32;3
WireConnection;33;1;30;0
WireConnection;14;0;26;0
WireConnection;14;1;27;0
WireConnection;21;0;34;0
WireConnection;21;1;33;0
WireConnection;22;0;21;0
WireConnection;4;0;14;0
WireConnection;39;0;22;0
WireConnection;39;2;60;0
WireConnection;36;0;4;0
WireConnection;36;2;59;0
WireConnection;3;0;36;0
WireConnection;23;0;39;0
WireConnection;24;0;3;0
WireConnection;24;1;23;0
WireConnection;12;0;3;0
WireConnection;12;1;24;0
WireConnection;12;2;25;0
WireConnection;12;3;57;0
WireConnection;12;4;2;0
WireConnection;49;0;12;0
WireConnection;52;0;49;0
WireConnection;52;1;49;1
WireConnection;53;0;52;0
WireConnection;53;1;49;2
WireConnection;58;0;53;0
WireConnection;58;1;49;3
WireConnection;54;0;58;0
WireConnection;54;1;2;4
WireConnection;1;2;12;0
WireConnection;1;10;54;0
ASEEND*/
//CHKSM=B86833C166C89A098B01CEA8CB97297BA9B621CC