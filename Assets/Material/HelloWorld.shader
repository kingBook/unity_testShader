Shader "Custom/HelloWorld"{
	SubShader{
		Pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			struct a2v{
				float4 vertex:POSITION;		//模型空间顶点坐标
				float3 normal:NORMAL;		//模型空间顶点的法线
				float4 texcoord:TEXCOORD0;	//模型空间顶点的纹理0坐标
			};
			
			struct v2f{
				float4 pos:SV_POSITION;
				float3 color:COLOR0;
			};
			
			v2f vert(a2v v){
				v2f o;
				//v.normal包含了顶点的法线方向，其分量范围在[-1.0,1.0]
				//下面的代码把分量范围映射到了[0.0,1.0]
				//存储到o.color中传递给片元着色器
				o.pos=UnityObjectToClipPos(v.vertex);
				o.color=v.normal*0.5+fixed3(0.5,0.5,0.5);
				return o;
			}
			fixed4 frag(v2f i):SV_Target{
				//将插值后的i.color显示到屏幕上
				return fixed4(i.color,1.0);
			}
			ENDCG
		}
	}
	Fallback "VertexLit"
}

