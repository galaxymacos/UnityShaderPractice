﻿Shader "Custom/CustomBlinn"{
    Properties{
        _Colour("Colour", Color) = (1,1,1,1)
    }
    
    SubShader{
        Tags{
            "Queue" = "Geometry"
        }
    
        CGPROGRAM
        #pragma surface surf BasicBlinn
        
        // atten: how much light to reduce when they are hit on the surface
        // The name "LightingBasicLambert" must match "BasicLambert" in the #pragma session
        half4 LightingBasicBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten){
            // Calculate half-way vector
            half3 h = normalize(lightDir + viewDir);
            
            // The diffuse light is determined by the normal direction and the light source dir
            half diff = max(0, dot(s.Normal, lightDir));
            
            float nh = max(0,dot(s.Normal, h));
            float spec = pow(nh, 48.0);
            
            half4 c;
            // c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec)*atten;
            // Move the shader in real time
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec)*atten*_SinTime;
            c.a = s.Alpha;
            return c;
            
        }
        
        float4 _Colour;
        
        struct Input{
            float2 uv_MainTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o){
            o.Albedo = _Colour.rgb;
        }
        
        
        ENDCG
    }
    
    FallBack "Diffuse"
}