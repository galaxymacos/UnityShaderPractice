Shader "Unlit/ColorScreenVF"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1,0,0,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

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
            float4 _Color;

            v2f vert (appdata v)    
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);  // convert the pixel from world space to screen space
                
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target // change the pixel info on the screen (Because the pixel position is relative to the screen, if you move, the color you see will change to)
            {
                fixed4 col = i.color;
                col = fixed4(1,0,0,1);
               // newColor.r = (i.vertex.x+500)/1000;
              //  newColor.g = (i.vertex.y+500)/1000;
                return col;
                // return i.vertex.x/1000;
                // return col;
            }
            ENDCG
        }
    }
}
