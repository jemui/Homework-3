Shader "Custom/ParticleShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        
        //Define properties for Start and End Color
        _StartColor ("StartColor", Color) = (0,0,0,1)
        _EndColor ("EndColor", Color) = (0,0,0,1)
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Opaque" }
        LOD 100
        
        Blend One One
        ZWrite off
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            struct appdata
            {
                float4 vertex : POSITION;
                //Define UV data
                float3 uv : TEXCOORD0;
            };

            struct v2f
            {   
                float4 vertex : SV_POSITION;
                //Define UV data
                float3 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            
            uniform float4 _StartColor;
            uniform float4 _EndColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv; // Correct this for particle shader
                
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                //Get particle age percentage
                float particleAgePercentage = i.uv.z;

                //Sample color from particle texture
                float4 col = tex2D(_MainTex, i.uv.xy); 

                //Find "start color"
                float4 start = _StartColor; 
                
                //Find "end color"
                float4 end = _EndColor;

                //Do a linear interpolation of start color and end color based on particle age percentage
                float4 finalCol = lerp(start, end, particleAgePercentage)*col.a;
                return finalCol;
            }
            ENDCG
        }
    }
}
