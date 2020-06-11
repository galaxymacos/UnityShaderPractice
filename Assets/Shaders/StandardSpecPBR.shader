Shader "Custom/StandardSpecPBR"{
    Properties{
        _Color("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic (R)", 2D) = "white"{}
        // _Metallic("Metallic", Range(0.0, 1.0)) = 0.0
        _SpecColor("Specular", Color) = (1,1,1,1)
    }
    
    SubShader{
        Tags{
            "Queue" = "Geometry"
        }
        
        CGPROGRAM
            #pragma surface surf StandardSpecular
            
            fixed4 _Color;
            sampler2D _MetallicTex;
            // half _Metallic;
            
            struct Input{
                float2 uv_MetallicTex;
            };
            
            void surf (Input IN, inout SurfaceOutputStandardSpecular o){
                o.Albedo = _Color.rgb;
                o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
                o.Specular = _SpecColor.rgb; // can't set a float4 to equal to a float (The texture will look gray because it is filling the rgb channels with gray)
            }
            
        ENDCG
    }
}