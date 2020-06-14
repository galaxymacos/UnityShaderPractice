// Simulate lighting on frag vert shader

Shader "Unlit/VFDiffuse"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass{
            Tags {"LightMode"="ForwardBase"}    // Set up for forwarding rendering
            
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                #include "UnityLightingCommon.cginc"

                struct appdata{
                    float4 vertex: POSITION;
                    float3 normal: NORMAL;
                    float4 texcoord: TEXCOORD0;
                };

                struct v2f{
                    float2 uv: TEXCOORD0;
                    float4 diff: COLOR0;
                    float4 vertex: SV_POSITION;
                };

                v2f vert(appdata v){
                    v2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    // equivalent to o.vertex = mul(UNITY_MATRIX_MVP, v.vertex)
                    o.uv = v.texcoord;
                    half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                    half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                    o.diff = nl * _LightColor0;
                    return o;
                }
                
                sampler2D _MainTex;

                fixed4 frag(v2f i): SV_TARGET{
                    fixed4 col = tex2D(_MainTex, i.uv);     // get the color of the texture
                    col*=i.diff;    // multiple it by the diffuse color of the light
                    return col;
                }

            ENDCG
        }
    }
}
