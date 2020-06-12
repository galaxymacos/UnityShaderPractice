Shader "Custom/Blend SrcAlpha OneMinusSrcAlpha"
{
    Properties{
        _MainTex("Texture", 2D) = "white" {}
    }
    
    SubShader{
        Tags{"Queue" = "Transparent"}
        Blend SrcAlpha OneMinusSrcAlpha   // If the quad alpha is 0, SrcAlpha will be 0, the quad will disappear
                        // If the quad alpha is 0, OneMinusSrcAlpha will be 1, the z buffer will show
        Pass{
            SetTexture [_MainTex] {combine texture}
        }
    }
}
