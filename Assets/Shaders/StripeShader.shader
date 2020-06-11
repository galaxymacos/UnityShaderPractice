Shader "Custom/Stripe" {
    Properties{
        
    }

    SubShader{
        
        CGPROGRAM
        
        #pragma surface surf Lambert
        
        struct Input{
            float3 worldPos;
        };
        
        void surf (Input IN, inout SurfaceOutput o){
            o.Emission = frac(IN.worldPos.y * 5)>0.4?float3(0,1,1):float3(1,1,0);
        }
        
        ENDCG    
    }
    
    FallBack "Diffuse"
}