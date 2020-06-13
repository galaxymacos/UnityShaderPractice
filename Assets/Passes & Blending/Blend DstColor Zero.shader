Shader "Custom/Blend DstColor Zero"
{
    Properties{
        _MainTex("Texture", 2D) = "white" {}
    }
    
    SubShader{
        Tags{"Queue" = "Transparent"}
        Blend DstColor Zero   // Multiple the destination color with the source color (Kind of like mixing those two colors together in a way)
                        // Zero: Clear the color in the z buffer
        Pass{
            SetTexture [_MainTex] {combine texture}
        }
    }
}
