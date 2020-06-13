﻿Shader "Custom/Hole"
{
    Properties
    {
        _MainTex("Diffuse", 2D) = "white" {}
    }
    SubShader
    {
        // make the hole to draw before the geometry
        Tags {"Queue" = "Geometry-1"}
        
        ColorMask 0 // turn off the color being drawn
        ZWrite off  // 
        Stencil
        {
            Ref 1
            Comp always
            Pass replace    // one draw call
        }
    
       CGPROGRAM
       #pragma surface surf Lambert
       
       sampler2D _MainTex;
       
       struct Input{
            float2 uv_MainTex;
       };
       
       void surf (Input IN, inout SurfaceOutput o){
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
       }
       
       ENDCG
    }
    FallBack "Diffuse"
}
