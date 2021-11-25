Shader "Unlit/S_Unlit_Color"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vertexShader
            #pragma fragment fragmentShader

            #include "UnityCG.cginc"

            float4 _Color;

            // automatically filled out by Unity and passed
            // to the vertex shader
            struct MeshData
            {
                float4 vertex : POSITION;
            };

            // data passed from the vertex shader to the
            // fragment shader
            struct Interpolators
            {
                float4 vertex : SV_POSITION; // clip space position
            };

            Interpolators vertexShader (MeshData meshData)
            {
                Interpolators interpolators;
                interpolators.vertex = UnityObjectToClipPos(meshData.vertex); // local space to clip space
                return interpolators;
            }

            float4 fragmentShader (Interpolators interpolators) : SV_Target
            {
                return _Color;
            }
            ENDCG
        }
    }
}
