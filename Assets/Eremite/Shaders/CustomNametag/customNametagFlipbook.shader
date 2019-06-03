// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Eremite/customNametagFlipbook"
{
	Properties
	{
		_Flip("Flip", Range( 0 , 1)) = 0
		_NameTagTex("NameTagTex", 2D) = "white" {}
		_NameTagColor("NameTagColor", Color) = (1,1,1,0)
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Columns("Columns", Int) = 1
		_Rows("Rows", Int) = 1
		_StartFrame("StartFrame", Int) = 0
		_Speed("Speed", Float) = 0
		_Emission("Emission", Range( 0 , 5)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+549" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha One
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Flip;
		uniform sampler2D _NameTagTex;
		uniform int _Columns;
		uniform int _Rows;
		uniform float _Speed;
		uniform int _StartFrame;
		uniform float4 _NameTagColor;
		uniform float _Emission;
		uniform float _Smoothness;


		float3 GetLocalCameraPosition435( float3 up )
		{
			float3 centerEye = _WorldSpaceCameraPos.xyz; 
			#if UNITY_SINGLE_PASS_STEREO 
			int startIndex = unity_StereoEyeIndex; 
			unity_StereoEyeIndex = 0; 
			float3 leftEye = _WorldSpaceCameraPos; 
			unity_StereoEyeIndex = 1; 
			float3 rightEye = _WorldSpaceCameraPos;
			unity_StereoEyeIndex = startIndex;
			centerEye = lerp(leftEye, rightEye, 0.5);
			#endif 
			float3 cam = mul(unity_WorldToObject, float4(centerEye, 1)).xyz;
			return cam;
		}


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		float4x4 GenerateLookMatrix1( float3 target , float3 up )
		{
			float3 zaxis = normalize(target.xyz);
			float3 xaxis = normalize(cross(up, zaxis));
			float3 yaxis = cross(zaxis, xaxis);
			float4x4 lookMatrix = float4x4(xaxis.x, yaxis.x, zaxis.x, 0,xaxis.y, yaxis.y, zaxis.y, 0, xaxis.z, yaxis.z, zaxis.z, 0, 0, 0, 0, 1);
			return lookMatrix;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 lerpResult511 = lerp( float3(0,0,1) , float3(0,1,0) , (float)1);
			float3 UpVector478 = lerpResult511;
			float3 up435 = UpVector478;
			float3 localGetLocalCameraPosition435 = GetLocalCameraPosition435( up435 );
			float3 rotatedValue509 = RotateAroundAxis( float3( 0,0,0 ), localGetLocalCameraPosition435, float3(1,0,0), -1.57 );
			float3 lerpResult518 = lerp( rotatedValue509 , localGetLocalCameraPosition435 , UpVector478.y);
			float3 _Vector0 = float3(0,0,0);
			float3 rotatedValue542 = RotateAroundAxis( float3( 0,0,0 ), _Vector0, float3(1,0,0), -1.57 );
			float3 lerpResult543 = lerp( rotatedValue542 , _Vector0 , UpVector478.y);
			float3 normalizeResult384 = normalize( ( lerpResult518 + lerpResult543 ) );
			float Backward534 = round( _Flip );
			float3 lerpResult533 = lerp( normalizeResult384 , ( float3(-1,-1,-1) * normalizeResult384 ) , Backward534);
			float3 target1 = lerpResult533;
			float3 up1 = float3(0,1,0);
			float4x4 localGenerateLookMatrix1 = GenerateLookMatrix1( target1 , up1 );
			int Maya537 = 1;
			float4x4 lerpResult526 = lerp( mul( mul( float4x4(1,0,0,0,0,0,-1,0,0,1,0,0,0,0,0,1), localGenerateLookMatrix1 ), float4x4(1,0,0,0,0,0,1,0,0,-1,0,0,0,0,0,1) ) , localGenerateLookMatrix1 , (float)Maya537);
			float3 ase_vertex3Pos = v.vertex.xyz;
			v.vertex.xyz = mul( lerpResult526, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 normalizeResult250 = normalize( ase_vertexNormal );
			v.normal = mul( lerpResult526, float4( normalizeResult250 , 0.0 ) ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			// *** BEGIN Flipbook UV Animation vars ***
			// Total tiles of Flipbook Texture
			float fbtotaltiles558 = (float)_Columns * (float)_Rows;
			// Offsets for cols and rows of Flipbook Texture
			float fbcolsoffset558 = 1.0f / (float)_Columns;
			float fbrowsoffset558 = 1.0f / (float)_Rows;
			// Speed of animation
			float fbspeed558 = _Time[ 1 ] * _Speed;
			// UV Tiling (col and row offset)
			float2 fbtiling558 = float2(fbcolsoffset558, fbrowsoffset558);
			// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
			// Calculate current tile linear index
			float fbcurrenttileindex558 = round( fmod( fbspeed558 + (float)_StartFrame, fbtotaltiles558) );
			fbcurrenttileindex558 += ( fbcurrenttileindex558 < 0) ? fbtotaltiles558 : 0;
			// Obtain Offset X coordinate from current tile linear index
			float fblinearindextox558 = round ( fmod ( fbcurrenttileindex558, (float)_Columns ) );
			// Multiply Offset X by coloffset
			float fboffsetx558 = fblinearindextox558 * fbcolsoffset558;
			// Obtain Offset Y coordinate from current tile linear index
			float fblinearindextoy558 = round( fmod( ( fbcurrenttileindex558 - fblinearindextox558 ) / (float)_Columns, (float)_Rows ) );
			// Reverse Y to get tiles from Top to Bottom
			fblinearindextoy558 = (int)((float)_Rows-1) - fblinearindextoy558;
			// Multiply Offset Y by rowoffset
			float fboffsety558 = fblinearindextoy558 * fbrowsoffset558;
			// UV Offset
			float2 fboffset558 = float2(fboffsetx558, fboffsety558);
			// Flipbook UV
			half2 fbuv558 = i.uv_texcoord * fbtiling558 + fboffset558;
			// *** END Flipbook UV Animation vars ***
			float4 tex2DNode544 = tex2D( _NameTagTex, fbuv558 );
			float4 temp_output_556_0 = ( tex2DNode544 * _NameTagColor );
			o.Albedo = temp_output_556_0.rgb;
			o.Emission = ( temp_output_556_0 * _Emission ).rgb;
			o.Smoothness = _Smoothness;
			o.Alpha = tex2DNode544.a;
		}

		ENDCG
		CGPROGRAM
		#pragma only_renderers d3d9 d3d11 glcore gles gles3 
		#pragma surface surf StandardSpecular keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandardSpecular o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardSpecular, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15600
64;107;1675;896;1093.56;1435.369;1.699681;True;True
Node;AmplifyShaderEditor.Vector3Node;473;-1602.17,-834.9199;Float;False;Constant;_Vector8;Vector 8;18;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.IntNode;546;-1576.56,-545.2334;Float;False;Constant;_Int0;Int 0;3;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.Vector3Node;472;-1602.203,-688.1844;Float;False;Constant;_Vector7;Vector 7;18;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;511;-1382.971,-708.4814;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;478;-1217.012,-713.8092;Float;False;UpVector;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;480;-2410.149,-250.8759;Float;False;478;UpVector;0;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;541;-2668.804,60.16531;Float;False;Constant;_Vector5;Vector 5;19;0;Create;True;0;0;False;0;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CustomExpressionNode;435;-2180.079,-190.0626;Float;False;float3 centerEye = _WorldSpaceCameraPos.xyz@ $#if UNITY_SINGLE_PASS_STEREO $int startIndex = unity_StereoEyeIndex@ $unity_StereoEyeIndex = 0@ $float3 leftEye = _WorldSpaceCameraPos@ $unity_StereoEyeIndex = 1@ $float3 rightEye = _WorldSpaceCameraPos@$unity_StereoEyeIndex = startIndex@$centerEye = lerp(leftEye, rightEye, 0.5)@$#endif $float3 cam = mul(unity_WorldToObject, float4(centerEye, 1)).xyz@$return cam@;3;False;1;True;up;FLOAT3;0,0,0;In;;Get Local Camera Position;True;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;510;-2126.917,210.3967;Float;False;Constant;_Float0;Float 0;19;0;Create;True;0;0;False;0;-1.57;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;508;-2128.549,62.21009;Float;False;Constant;_Vector4;Vector 4;19;0;Create;True;0;0;False;0;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;545;-2667.594,-119.9095;Float;False;Constant;_Vector0;Vector 0;19;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;540;-2667.173,208.3509;Float;False;Constant;_Float1;Float 1;19;0;Create;True;0;0;False;0;-1.57;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;487;-2188.65,-311.0319;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RotateAboutAxisNode;542;-2465.102,13.9173;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;509;-1828.507,-42.10278;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;518;-1471.466,-290.7917;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;543;-1765.043,-168.2359;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;527;-1831.004,-459.9776;Float;False;Property;_Flip;Flip;0;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;375;-1256.19,-239.553;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RoundOpNode;528;-1556.018,-452.8783;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;532;-976.3101,-498.8553;Float;False;Constant;_Vector14;Vector 14;20;0;Create;True;0;0;False;0;-1,-1,-1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;384;-1106.714,-217.8571;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;531;-771.3115,-428.8552;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;534;-1414.164,-459.1669;Float;False;Backward;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;536;-809.5825,-154.8398;Float;False;534;Backward;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;519;-548.4604,-64.01582;Float;False;Constant;_Vector12;Vector 12;19;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;533;-586.6263,-233.491;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;560;-471.9056,-1127.252;Float;False;Property;_Columns;Columns;5;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;562;-482.7043,-899.5525;Float;False;Property;_StartFrame;StartFrame;7;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;561;-470.9056,-1057.252;Float;False;Property;_Rows;Rows;6;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;563;-464.9056,-980.2522;Float;False;Property;_Speed;Speed;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Matrix4X4Node;523;-518.6077,-445.8685;Float;False;Constant;_Matrix0;Matrix 0;19;0;Create;True;0;0;False;0;1,0,0,0,0,0,-1,0,0,1,0,0,0,0,0,1;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.CustomExpressionNode;1;-362.6848,-135.198;Float;False;float3 zaxis = normalize(target.xyz)@$float3 xaxis = normalize(cross(up, zaxis))@$float3 yaxis = cross(zaxis, xaxis)@$float4x4 lookMatrix = float4x4(xaxis.x, yaxis.x, zaxis.x, 0,xaxis.y, yaxis.y, zaxis.y, 0, xaxis.z, yaxis.z, zaxis.z, 0, 0, 0, 0, 1)@$return lookMatrix@$;6;False;2;True;target;FLOAT3;0,0,0;In;;True;up;FLOAT3;0,0,0;In;;GenerateLookMatrix;True;False;0;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4x4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;559;-491.9056,-1270.252;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCFlipBookUVAnimation;558;-200.6464,-1132.738;Float;False;0;0;6;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;524;-162.7024,-411.4515;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT4x4;0
Node;AmplifyShaderEditor.Matrix4X4Node;525;-359.8017,-314.3516;Float;False;Constant;_Matrix1;Matrix 1;19;0;Create;True;0;0;False;0;1,0,0,0,0,0,1,0,0,-1,0,0,0,0,0,1;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.NormalVertexDataNode;8;233.0303,-46.41915;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;555;280.4379,-832.4757;Float;False;Property;_NameTagColor;NameTagColor;3;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;544;215.3917,-1022.459;Float;True;Property;_NameTagTex;NameTagTex;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;537;-1399.132,-541.1048;Float;False;Maya;-1;True;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;538;-123.0405,-74.29633;Float;False;537;Maya;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;521;-21.69788,-375.0707;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT4x4;0
Node;AmplifyShaderEditor.RangedFloatNode;564;376.664,-505.6425;Float;False;Property;_Emission;Emission;9;0;Create;True;0;0;False;0;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;556;526.6039,-815.6915;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalizeNode;250;440.3581,-39.76048;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;7;246.2686,-329.289;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;526;103.7103,-221.853;Float;False;3;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;2;FLOAT;0;False;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;565;667.3094,-612.7226;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;652.3572,-236.1975;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;557;540.724,-368.0699;Float;False;Property;_Smoothness;Smoothness;4;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;650.1643,-102.9113;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;951.1072,-517.2842;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;Eremite/customNametagFlipbook;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;549;True;Transparent;;AlphaTest;ForwardOnly;True;True;True;True;True;False;False;False;False;False;False;False;False;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;511;0;473;0
WireConnection;511;1;472;0
WireConnection;511;2;546;0
WireConnection;478;0;511;0
WireConnection;435;0;480;0
WireConnection;487;0;480;0
WireConnection;542;0;541;0
WireConnection;542;1;540;0
WireConnection;542;3;545;0
WireConnection;509;0;508;0
WireConnection;509;1;510;0
WireConnection;509;3;435;0
WireConnection;518;0;509;0
WireConnection;518;1;435;0
WireConnection;518;2;487;1
WireConnection;543;0;542;0
WireConnection;543;1;545;0
WireConnection;543;2;487;1
WireConnection;375;0;518;0
WireConnection;375;1;543;0
WireConnection;528;0;527;0
WireConnection;384;0;375;0
WireConnection;531;0;532;0
WireConnection;531;1;384;0
WireConnection;534;0;528;0
WireConnection;533;0;384;0
WireConnection;533;1;531;0
WireConnection;533;2;536;0
WireConnection;1;0;533;0
WireConnection;1;1;519;0
WireConnection;558;0;559;0
WireConnection;558;1;560;0
WireConnection;558;2;561;0
WireConnection;558;3;563;0
WireConnection;558;4;562;0
WireConnection;524;0;523;0
WireConnection;524;1;1;0
WireConnection;544;1;558;0
WireConnection;537;0;546;0
WireConnection;521;0;524;0
WireConnection;521;1;525;0
WireConnection;556;0;544;0
WireConnection;556;1;555;0
WireConnection;250;0;8;0
WireConnection;526;0;521;0
WireConnection;526;1;1;0
WireConnection;526;2;538;0
WireConnection;565;0;556;0
WireConnection;565;1;564;0
WireConnection;9;0;526;0
WireConnection;9;1;7;0
WireConnection;10;0;526;0
WireConnection;10;1;250;0
WireConnection;0;0;556;0
WireConnection;0;2;565;0
WireConnection;0;4;557;0
WireConnection;0;9;544;4
WireConnection;0;11;9;0
WireConnection;0;12;10;0
ASEEND*/
//CHKSM=5746A27A163AB9E2E0454E215298D09FC956853B