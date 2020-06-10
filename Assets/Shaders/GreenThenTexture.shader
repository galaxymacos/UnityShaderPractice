Shader "Holistic/GreenThenTexture"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        
    }
    SubShader
    {
       

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

       
       fixed4 _Color;
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
            float4 green = float4(0,1,0,1);
            o.Albedo = (green * tex2D(_MainTex, IN.uv_MainTex)).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
