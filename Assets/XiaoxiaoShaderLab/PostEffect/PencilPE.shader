Shader "PostEffect/Sharp"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
                _BlurOffset("Blur Offset", Range(0, 0.5)) = 0.05
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            #include "Assets/XiaoxiaoShaderLab/PostEffect.cginc"
            #include "Assets/XiaoxiaoShaderLab/Method.cginc"

            float _BlurOffset;
        	fixed4 ProcessColor(v2f IN)
			{
	 float3x3 pencilFilter = 
                {
                    -0.5, -1.0, 0.0,
                    -1.0,  0.0, 1.0,
                     0.0,  1.0, 0.5
                };

                float4 filterCol = filterWithoutA(pencilFilter,_BlurOffset, _MainTex, IN.uv);
                float gray = 0.3 * filterCol.x + 0.59 * filterCol.y + 0.11 * filterCol.z;
                gray = 1.0 - gray;
                return float4(gray, gray, gray, filterCol.a);
			}

            v2f vert (appdata v)
            {
                return vert_default(v);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return frag_default(i);
            }
            ENDCG
        }
    }
}
