Shader "Custom/SpriteAnim"{
	Properties {
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
		//关键帧纹理
		_MainTex ("Image Sequence", 2D) = "white" {}
		//图像在水平方向上的关键帧个数
		_HorizontalAmount ("Horizontal Amount", Float) = 4
		//图像在垂直方向上的关键帧个数
		_VerticalAmount ("Vertical Amount", Float) = 4
		//控制序列帧的播放速度
		_Speed ("Speed", Range(1, 100)) = 30
	}
	SubShader {
		//由于序列帧图像通常都是透明纹理，我们需要设置Pass的相关状态，以渲染透明效果
		//Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			"PreviewType" = "Plane"
			"CanUseSpriteAtlas" = "True"
		}
 
		Cull Off
		Lighting Off
		ZWrite Off
		Blend One OneMinusSrcAlpha
		Pass {
			//Tags { "LightMode"="ForwardBase" }
			
			//ZWrite Off
			//Blend SrcAlpha OneMinusSrcAlpha
			
			
			CGPROGRAM
			
			#pragma vertex vert  
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			
			fixed4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _HorizontalAmount;
			float _VerticalAmount;
			float _Speed;
			  
			struct a2v {  
				float4 vertex : POSITION; 
				float2 texcoord : TEXCOORD0;
			};  
			
			struct v2f {  
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};  
			
			v2f vert (a2v v) {  
				v2f o;  
				o.pos = UnityObjectToClipPos(v.vertex);  
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);  
				return o;
			}  
			
			fixed4 frag (v2f i) : SV_Target {
				//_Time.y 是自该场景后所经过的时间，与速度相乘来得到模拟的时间，再用floor函数取整
				float time = floor(_Time.y * _Speed);  
				//获得行索引
				float row = floor(time / _HorizontalAmount);
				//获得列索引
				float column = time - row * _HorizontalAmount;
				
				//half2 uv = float2(i.uv.x /_HorizontalAmount, i.uv.y / _VerticalAmount);
				//uv.x += column / _HorizontalAmount;
				//uv.y -= row / _VerticalAmount;
				//进行位置偏移
				half2 uv = i.uv + half2(column, -row);
				//进行大小锁定
				uv.x /=  _HorizontalAmount;
				uv.y /= _VerticalAmount;
				//进行采样
				fixed4 c = tex2D(_MainTex, uv);
				c.rgb *= _Color;
				
				return c;
			}
			ENDCG
		}  
	}
	FallBack "Transparent/VertexLit"
}