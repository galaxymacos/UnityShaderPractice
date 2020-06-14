Shader "Unlit/PrefectGradient"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;   // the position of each vertice
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;    // the vertex is already converted to 2d screen space
                float4 color: COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            half FTR(float f, float r){
                return (f*2+r)/(r*2);
            }

            v2f vert (appdata v)    
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex); 
                o.color.rgb = FTR(v.vertex.x, 10);
                return o;
            }
            
            
            

            fixed4 frag (v2f i) : SV_Target // change the pixel info on the screen (Because the pixel position is relative to the screen, if you move, the color you see will change to)
            {
                fixed4 col = i.color;
                return col;
                
            }
            ENDCG
        }
    }
}
