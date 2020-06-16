Shader "Custom/VFPlasma"
{
	Properties {
      _Tint("Colour Tint", Color) = (1,1,1,1)
      _Speed("Speed", Range(1,100)) = 10
      _Scale1("Scale 1", Range(0.1,10)) = 2
      _Scale2("Scale 2", Range(0.1,10)) = 2
      _Scale3("Scale 3", Range(0.1,10)) = 2
      _Scale4("Scale 4", Range(0.1,10)) = 2
    }
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
 
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};
 
			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float4 worldPos: COLOR0;
			};
 
		float4 _Tint;
		    float _Speed;
		    float _Scale1;
		    float _Scale2;
		    float _Scale3;
		    float _Scale4;
			
			v2f vert (appdata v)
			{
				v2f o;
				 o.vertex = UnityObjectToClipPos(v.vertex);
				o.worldPos = mul(unity_ObjectToWorld,v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col;
 
				const float PI = 3.14159265;
	            float t = _Time.x * _Speed;
          
	            //vertical
	            float c = sin(i.worldPos.x * _Scale1 + t);
 
	            //horizontal
	            c += sin(i.worldPos.z * _Scale2 + t);
 
	            //diagonal
	            c += sin(_Scale3*(i.worldPos.x *sin(t/2.0) + i.worldPos.z *cos(t/3))+t);
 
	            //circular
	            float c1 = pow(i.worldPos.x  + 0.5 * sin(t/5),2);
	            float c2 = pow(i.worldPos.z  + 0.5 * cos(t/3),2);
	            c += sin(sqrt(_Scale4*(c1 + c2)+1+t));
 
	            col.r = sin(c/4.0*PI);
	            col.g = sin(c/4.0*PI + 2*PI/4);
	            col.b = sin(c/4.0*PI + 4*PI/4);
				return col;
			}
			ENDCG
		}
	}
}