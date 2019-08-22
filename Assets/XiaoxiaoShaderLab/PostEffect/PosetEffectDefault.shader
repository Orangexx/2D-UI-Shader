Shader "PostEffect/Default"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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

        	fixed4 ProcessColor(v2f IN)
			{
				return tex2D(_MainTex, IN.uv);
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
