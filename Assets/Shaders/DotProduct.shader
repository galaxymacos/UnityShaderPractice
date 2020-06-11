Shader "Holistic/DotProduct"{
    SubShader{
    
        CGPROGRAM
        
        #pragma surface surf Lambert
        
        struct Input{
            float3 viewDir;
        };
        
        
        void surf(Input IN, inout SurfaceOutput o){
            half dotp = dot(IN.viewDir, o.Normal);
            /// o.Albedo = float3(dotp,1,1);
            
            // Green Rim 
             o.Albedo.gb = float2(1-dot(IN.viewDir,o.Normal),0);
            
            // Pink Rim + White Center
             o.Albedo = float3(1,dot(IN.viewDir,o.Normal),1);
            
            // sky blue rim + blue center
            o.Albedo = float3(0,1 - dot(IN.viewDir,o.Normal), 1);
            
            
            // sky blue rim + yellow center
            o.Albedo = float3(dot(IN.viewDir,o.Normal), 1, 1-dot(IN.viewDir,o.Normal));
            
            // Red Rim
            o.Albedo = float3(1-dot(IN.viewDir,o.Normal), 0,0);
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}