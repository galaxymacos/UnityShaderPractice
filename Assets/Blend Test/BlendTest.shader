Shader "Custom/Blend One One"
{
    Properties{
        _MainTex("Texture", 2D) = "white" {}
    }
    
    SubShader{
        Tags{"Queue" = "Transparent"}
        
        // Black * One = Transparent; White * One = White
        Blend One One   // The "one" at the first: The color of the blend
                        // The "one" at the second: The color of what's at the z-buffer (Thing that is behind the quad) 
        Pass{
            SetTexture [_MainTex] {combine texture}
        }
    }
}
