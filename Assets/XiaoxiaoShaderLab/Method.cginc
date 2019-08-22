    float4 filterWithA(float3x3 filter,float _BlurOffset, sampler2D tex, float2 coord)
    {
                float4 outCol = float4(0,0,0,0);
                for (int i = 0; i < 3; i++)
                {
                    for (int j = 0; j < 3; j++)
                    {
                        //计算采样点，得到当前像素附近的像素的坐标
                        float2 newUV= float2(coord.x + (i-1)*_BlurOffset, coord.y + (j-1)*_BlurOffset);
                        //采样并乘以滤波器权重，然后累加
                        outCol += tex2D(tex, newUV) * filter[i][j];
                    }
                }
				//是否处理透明度
				//outCol.a = tex2D(tex, coord).a;
                return abs(outCol);
    }
	float4 filterWithoutA(float3x3 filter, float _BlurOffset, sampler2D tex, float2 coord)
	{
		float4 outCol = float4(0, 0, 0, 0);
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 3; j++)
			{
				//计算采样点，得到当前像素附近的像素的坐标
				float2 newUV = float2(coord.x + (i - 1)*_BlurOffset, coord.y + (j - 1)*_BlurOffset);
				//采样并乘以滤波器权重，然后累加
				outCol += tex2D(tex, newUV) * filter[i][j];
			}
		}
		//是否处理透明度
		outCol.a = tex2D(tex, coord).a;
		return abs(outCol);
	}