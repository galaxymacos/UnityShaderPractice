Shader "Custom/WorldPosColorDifferenceShader" {
    Properties{
        
    }

    SubShader{
        
        CGPROGRAM
        
        #pragma surface surf Lambert
        
        struct Input{
            float3 worldPos;
        };
        
        void surf (Input IN, inout SurfaceOutput o){
            o.Emission = IN.worldPos.y > 1 ? float3(0,1,0):float3(1,0,0);
        }
        
        ENDCG    
    }
    
    FallBack "Diffuse"
}