Shader "Custom/StripeAndRim" {
    Properties{
        _diffuse("Diffuse Texture", 2D) = "white"{}
        _stripeDensity("Stripe Density",Range(0.5,10)) = 5
    }

    SubShader{
        
        CGPROGRAM
        
        #pragma surface surf Lambert
        
        sampler2D _diffuse;
        half _stripeDensity;
        
        struct Input{
            float3 worldPos;
            float3 viewDir;
            float2 uv_diffuse;
        };
        
        void surf (Input IN, inout SurfaceOutput o){
            o.Albedo = tex2D(_diffuse, IN.uv_diffuse).rgb;
            half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = frac(IN.worldPos.y * _stripeDensity)>0.4?float3(0,1,1):float3(1,1,0);
            
            // The normal info make the texture appear again 
            o.Emission*=rim;
        }
        
        ENDCG    
    }
    
    FallBack "Diffuse"
}