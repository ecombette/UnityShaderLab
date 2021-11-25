Shader "Unlit/S_Unlit_UV_Wave"
{
    Properties
    {
        _WaveCount ("Wave Count", Int) = 3
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

            #define TAU 6.28318530718
            
            int _WaveCount;

            // automatically filled out by Unity and passed
            // to the vertex shader
            struct MeshData
            {
                float4 vertex : POSITION;
                // float3 normals : NORMAL;
                // float4 tangent : TANGENT;
                // float4 color: COLOR;
                float4 uv0 : TEXCOORD0; // uv0 diffuse/normal map textures
                // float2 uv1 : TEXCOORD1; // uv1 lightmap coordinates
            };

            // data passed from the vertex shader to the
            // fragment shader
            struct Interpolators
            {
                float4 vertex : SV_POSITION; // clip space position
                float2 uv : TEXCOORD0;
            };

            Interpolators vertexShader (MeshData meshData)
            {
                Interpolators interpolators;
                interpolators.vertex = UnityObjectToClipPos(meshData.vertex); // local space to clip space
                interpolators.uv = meshData.uv0; // simple passthrough
                return interpolators;
            }

            float4 fragmentShader (Interpolators interpolators) : SV_Target
            {
                return cos(interpolators.uv.x * TAU * _WaveCount);
            }
            ENDCG
        }
    }
}
