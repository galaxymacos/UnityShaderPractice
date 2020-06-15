Shader "Custom/SimpleOutline"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _OutlineColor("Outline color", Color) = (0,0,0,1)
        _Outline("Outline width", Range(0.002, 0.1)) = .005
    }
    SubShader
    {
        ZWrite off
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert
        struct Input{
            float2 uv_MainTex;
        };
        float _Outline;
        float4 _OutlineColor;

        void vert(inout appdata_full v){
            v.vertex.xyz += v.normal*_Outline;
        }

        sampler2D _MainTex;
        void surf(Input IN, inout SurfaceOutput o){
            o.Emission = _OutlineColor.rgb;
        }


        ENDCG



        ZWrite on
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        float4 _OutlineColor;
        half _Outline;

        struct Input{
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o){
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }

        ENDCG
    }
    FallBack "Diffuse"
}