Shader "Custom/ToonRamp"{
    Properties{
        _Colour("Colour", Color) = (1,1,1,1)
        _RampTex("Ramp Texture", 2D) = "white"{}
    }
    
    SubShader{
    
        CGPROGRAM
        #pragma surface surf ToonRamp
        
        float4 _Colour;
        sampler2D _RampTex;
        
        // atten: how much light to reduce when they are hit on the surface
        // The name "LightingBasicLambert" must match "BasicLambert" in the #pragma session
        half4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten){
            float diff = dot(s.Normal, lightDir);
            float h = diff * 0.5 + 0.5; // At a bright spot, diff = 1, h = 1, the UV(1,1) is the top right spot
                                        // AT a dark spot, diff = 0, h = 0.5,
            float2 rh = h;
            float3 ramp = tex2D(_RampTex, rh).rgb;
            
            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            c.a = s.Alpha;
            return c;
        }
        
        
        struct Input{
            float2 uv_MainTex;
            float3 viewDir;
        };
        
        void surf (Input IN, inout SurfaceOutput o){
            // o.Albedo = _Colour.rgb;
            // use ramp image to the surface albedo 
            // use normal and viewDir to determine the uvs
            float diff = dot(o.Normal, viewDir);
            float h = diff*0.5+0.5;
            float2 rh = h;
            o.Albedo = tex2D(_RampTex, rh).rgb;
        }
        
        
        ENDCG
    }
    
    FallBack "Diffuse"
}