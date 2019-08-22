Shader "PostEffect/Blur"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BlurOffset("Blur Offset", Range(0, 0.5)) = 0.03
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
                 float3x3 boxFilter = 
                {
                    1.0f/9, 1.0f/9, 1.0f/9, 
                    1.0f/9, 1.0f/9, 1.0f/9, 
                    1.0f/9, 1.0f/9, 1.0f/9, 
                };
                
                return filterWithA(boxFilter,_BlurOffset, _MainTex,IN.uv);
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
