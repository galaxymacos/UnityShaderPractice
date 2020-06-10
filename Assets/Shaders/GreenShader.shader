Shader "Holistic/GreenShader"
{
    Properties
    {
        _myColor ("Example Color", Color) = (0,1,0,1)
        _myTex("Example Tex",2D) = "white"{}
    }
    SubShader
    {
       
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert


        sampler2D _myTex;

        struct Input
        {
            float2 uv_myTex;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = (tex2D(_myTex, IN.uv_myTex)).rgb;
            o.Albedo.g = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
