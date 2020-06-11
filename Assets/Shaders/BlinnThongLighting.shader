Shader "Custom/BasicBlinn"{
    Properties{
        _Colour("Colour", Color) = (1,1,1,1)
        _SpecColor("Specular color", Color) = (1,1,1,1)
        
        _Spec("Specular Size", Range(0,1)) = 0.5    // Define how much area the specular effect has covered
        
        _Gloss("Gloss", Range(0,1)) = 0.5       // Define how compact the specular is, how diffuse is it across the surface
    }
    
    SubShader{
        Tags{
            "Queue" = "Geometry"
        }
    
        CGPROGRAM
        #pragma surface surf BlinnPhong
        
        float4 _Colour;
        half _Spec;
        half _Gloss;
        // _SpecColor has been built in Unity, so we don't need to define it in CGPROGRAM
        
        struct Input{
            float2 uv_MainTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o){
            o.Albedo = _Colour.rgb;
            o.Specular = _Spec;
            o.Gloss = _Gloss;
        }
        
        
        ENDCG
    }
    
    FallBack "Diffuse"
}