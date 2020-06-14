Shader "Unlit/ColorVF"
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

            v2f vert (appdata v)    
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);  // convert the pixel from world space to screen space
                o.color.r = (v.vertex.x+5)/10;  // In my example, the leftmost vertex has x = -5, the rightmost vertex has x = 5, so it will changed to (0,1)
                o.color.g = (v.vertex.z+5)/10;
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target // change the pixel info on the screen (Because the pixel position is relative to the screen, if you move, the color you see will change to)
            {
                fixed4 col = i.color;
                return col;
                //fixed4 newColor = (1,1,1,1);
                //newColor.r = i.vertex.x/1000;
                //newColor.g = i.vertex.y/1000;
                //return newColor;
                // return i.vertex.x/1000;
                // return col;
            }
            ENDCG
        }
    }
}
