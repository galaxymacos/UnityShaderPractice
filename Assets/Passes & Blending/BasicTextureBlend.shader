Shader "Custom/BasicTextureBlend"
{
    Properties{
        _MainTex("MainTex", 2D) = "white" {}
        _DecalTex("Decal", 2D) = "white" {}
        [Toggle] _ShowDecal("Show Decal?", Float) = 0
    }
    
    SubShader{
        Tags{"Queue" = "Transparent"}
    
        CGPROGRAM
        #pragma surface surf Lambert
        sampler2D _MainTex;
        sampler2D _DecalTex;
        float _ShowDecal;
        
        struct Input{
            float2 uv_MainTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o){
            fixed4 a = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 b = tex2D(_DecalTex, IN.uv_MainTex) * _ShowDecal;
            o.Albedo = a.rgb * b.rgb;   // Wherever the decal is black, the image will be black, which is not what we want
            o.Albedo = a.rgb + b.rgb;   // Because we add the color of the original image and the decal together, the color is not accurate
            o.Albedo = b.r > 0.9 ? b.rgb : a.rgb; // if the decal has white, then use the decal instead of the original image
        }
        
        ENDCG
    }
    FallBack "Diffuse"
}
