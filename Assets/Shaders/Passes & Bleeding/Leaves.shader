// We need to set the render queue to transparent so that it will be drawn at the end. 
// In the alphatest channel, the lighting will be drawn first, and then the leave will be rendered, which is not what I want because I want the shadow of the leaf to be shown on the background

Shader "Holistic/Leaves" {
Properties{
        _MainTex ("MainTex", 2D) = "white" {}
    }
 
    SubShader{
        Tags{
            "Queue" = "Transparent"
        }
                              
        CGPROGRAM
        #pragma surface surf Lambert alphatest:_Cutoff addshadow 
        sampler2D _MainTex;
        struct Input {
            float2 uv_MainTex;
        };
 
        void surf(Input IN, inout SurfaceOutput o) {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            if (c.a < 0.5) discard;    // if the alpha of the current pixel is less than 0.5, then don't render this pixel
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}