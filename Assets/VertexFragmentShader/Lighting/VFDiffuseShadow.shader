// Simulate lighting on frag vert shader

Shader "Unlit/VFDiffuseShadow"
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
                #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight  // receive shadow
                #include "UnityCG.cginc"
                #include "UnityLightingCommon.cginc"
                #include "Lighting.cginc"
                #include "AutoLight.cginc"


                struct appdata{
                    float4 vertex: POSITION;
                    float3 normal: NORMAL;
                    float4 texcoord: TEXCOORD0;
                };

                struct v2f{
                    float2 uv: TEXCOORD0;
                    float4 diff: COLOR0;
                    float4 pos: SV_POSITION;
                    SHADOW_COORDS(1)
                };

                v2f vert(appdata v){
                    v2f o;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    // equivalent to o.vertex = mul(UNITY_MATRIX_MVP, v.vertex)
                    o.uv = v.texcoord;
                    half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                    half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                    o.diff = nl * _LightColor0;
                    TRANSFER_SHADOW(o); // looking for v2f.pos

                    return o;
                }
                
                sampler2D _MainTex;

                fixed4 frag(v2f i): SV_TARGET{
                    fixed4 col = tex2D(_MainTex, i.uv);     // get the color of the texture
                    fixed shadow = SHADOW_ATTENUATION(i);
                    col.rgb *= i.diff *shadow;
                    return col;
                }

            ENDCG
        }

        Pass{
            Tags {"LightMode"="ShadowCaster"}

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #include "UnityCG.cginc"

            struct appdata{
                float4 vertex: POSITION;
                float3 normal: NORMAL;
                float4 texcoord:TEXCOORD0;
            };

            struct v2f{
                V2F_SHADOW_CASTER;
            };

            v2f vert(appdata v){
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o);
                return o;
            }

            float4 frag(v2f i): SV_Target{

                SHADOW_CASTER_FRAGMENT(i);
            }


            ENDCG
        }
    }
}
