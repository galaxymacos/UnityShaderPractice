Shader "Custom/StandardPBR"{
    Properties{
        _Color("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic (R)", 2D) = "white"{}
        _Metallic("Metallic", Range(0.0, 1.0)) = 0.0
        _Glow("Glow", Range(0.0, 10.0)) = 5
    }
    
    SubShader{
        Tags{
            "Queue" = "Geometry"
        }
        
        CGPROGRAM
            #pragma surface surf Standard
            
            fixed4 _Color;
            sampler2D _MetallicTex;
            half _Metallic;
            half _Glow;
            
            struct Input{
                float2 uv_MetallicTex;
            };
            
            void surf (Input IN, inout SurfaceOutputStandard o){
                o.Albedo = _Color.rgb;
                o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
                o.Metallic = _Metallic;
                o.Emission = tex2D(_MetallicTex, IN.uv_MetallicTex).r * _Glow;
            }
            
        ENDCG
    }
}