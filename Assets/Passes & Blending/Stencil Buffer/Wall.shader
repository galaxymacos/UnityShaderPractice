Shader "Custom/Wall"
{
    Properties
    {
        _MainTex("Diffuse", 2D) = "white" {}
    }
    SubShader
    {
        
        Tags {"Queue" = "Geometry"}
    
        Stencil{
            Ref 1
            Comp notequal   // if the pixel in stencil buffer is different than the pixel this shader is going to draw on the stencil buffer
            Pass keep       // keep the original pixel that's in the stencil buffer and ignore what this shader is going to draw on the stencil buffer
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
