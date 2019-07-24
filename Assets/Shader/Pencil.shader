Shader "UI/Pencil"
{
	Properties
	{
		[PerRendererData] _MainTex("Sprite Texture", 2D) = "white" {}
		_Color("Tint", Color) = (1,1,1,1)
		_BlurOffset("Blur Offset", Range(0, 0.5)) = 0.05

		_StencilComp("Stencil Comparison", Float) = 8
		_Stencil("Stencil ID", Float) = 0
		_StencilOp("Stencil Operation", Float) = 0
		_StencilWriteMask("Stencil Write Mask", Float) = 255
		_StencilReadMask("Stencil Read Mask", Float) = 255

		_ColorMask("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("Use Alpha Clip", Float) = 0
	}

		SubShader
		{
			Tags
			{
				"Queue" = "Transparent"
				"IgnoreProjector" = "True"
				"RenderType" = "Transparent"
				"PreviewType" = "Plane"
				"CanUseSpriteAtlas" = "True"
			}

			Stencil
			{
				Ref[_Stencil]
				Comp[_StencilComp]
				Pass[_StencilOp]
				ReadMask[_StencilReadMask]
				WriteMask[_StencilWriteMask]
			}

			Cull Off
			Lighting Off
			ZWrite Off
			ZTest[unity_GUIZTestMode]
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask[_ColorMask]

			Pass
			{
				Name "Default"
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 2.0

				#include "UnityCG.cginc"
				#include "UnityUI.cginc"

				#pragma multi_compile __ UNITY_UI_CLIP_RECT
				#pragma multi_compile __ UNITY_UI_ALPHACLIP

				#include "Assets/Shader/UIDefault.cginc"
                float _BlurOffset;
				fixed4 ProcessColor(v2f IN)
				{
					 float3x3 pencilFilter = 
                {
                    -0.5, -1.0, 0.0,
                    -1.0,  0.0, 1.0,
                     0.0,  1.0, 0.5
                };

                float4 filterCol = filterWithoutA(pencilFilter,_BlurOffset, _MainTex, IN.texcoord);
                float gray = 0.3 * filterCol.x + 0.59 * filterCol.y + 0.11 * filterCol.z;
                gray = 1.0 - gray;
                return float4(gray, gray, gray, filterCol.a);
				}

				v2f vert(appdata_t IN)
				{
					return vert_default(IN);
				}

				fixed4 frag(v2f IN) : SV_Target
				{
					return frag_default(IN);
				}

				ENDCG
			}
		}
}
