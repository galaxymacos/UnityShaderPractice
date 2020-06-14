Shader "Unlit/Ripple"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ScaleUVX ("Scale X", Range(0,10)) = 1
        _ScaleUVY ("Scale Y", Range(0,10)) = 1
        
    }
    SubShader
    {

        GrabPass{}

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;  // we write 0 here because we might have multiple materials on an object
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _ScaleUVX;
            float _ScaleUVY;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                
                // ripple effect
                o.uv.x = sin(v.uv.x * _ScaleUVX);
                o.uv.y = sin(v.uv.y * _ScaleUVY);
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
