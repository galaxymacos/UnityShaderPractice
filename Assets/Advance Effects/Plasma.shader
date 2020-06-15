Shader "Custom/Plasma"
{
    Properties
    {
        _Tint("Colour Tint", Color) = (1,1,1,1)
        _Speed("Speed", Range(1,100)) = 10
        _Scale1("Scale 1", Range(0.1,10)) = 2
        _Scale2("Scale 2", Range(0.1,10)) = 2
        _Scale3("Scale 3", Range(0.1,10)) = 2
        _Scale4("Scale 4", Range(0.1,10)) = 2
        
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input {
            float2 uv_MainTex;
            float3 worldPos;    // detect what color of the plasma to show
        };
        
        float4 _Tint;
        float _Speed;
        float _Scale1;
        float _Scale2;
        float _Scale3;
        float _Scale4;
        
        void surf(Input IN, inout SurfaceOutput o){
            const float PI = 3.14159265;
            float t = _Time.x * _Speed;
            
            // vertical 
            float c = sin(IN.worldPos.x * _Scale1 + t);
            
            o.Albedo = sin(c/4.0*PI);
            o.Albedo *= _Tint;
        }
        
        
        ENDCG
    }
    FallBack "Diffuse"
}
