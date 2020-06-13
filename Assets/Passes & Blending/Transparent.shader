Shader "Custom/Transparent"
{
    Properties{
        _MainTex("Texture", 2D) = "black" {}
    }
    
    SubShader{
        Tags{"Queue" = "Transparent"}
        Blend SrcAlpha OneMinusSrcAlpha
                        
        // This line shows the two side of the billboard
        Cull Off
        Pass{
            SetTexture [_MainTex] {combine texture}
        }
    }
}
