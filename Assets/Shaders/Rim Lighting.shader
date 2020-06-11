Shader "Holistic/Rim"{
    Properties{
        _RimColor("Rim Color", Color) = (0,0.5,0.5,0.0)
        _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
    }
    
    SubShader{
        CGPROGRAM
        
        #pragma surface surf Lambert
        
        float4 _RimColor;
        float _RimPower;
        
        struct Input{
            float3 viewDir;
        };
        
        void surf (Input IN, inout SurfaceOutput o){
        
            // saturate: clamp the value to the range of (0,1), because we can't see the value when dot() = -1 anyway
            half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
            // pow() make the darker area darker, the brightness area brighter because of the exponential curve 0.9^2 is close to 1, 0.1^2 is close to 0
            o.Emission = _RimColor.rgb*pow(rim,_RimPower);
            
            // Make rim solid (logical cutoffs)
            o.Emission = rim>0.5?float3(1,0,0):rim>0.3?float3(0,1,0):0;
            
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}