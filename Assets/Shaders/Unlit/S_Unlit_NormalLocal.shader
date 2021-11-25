Shader "Unlit/S_Unlit_NormalLocal"
{
    Properties { }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vertexShader
            #pragma fragment fragmentShader

            #include "UnityCG.cginc"

            // automatically filled out by Unity and passed
            // to the vertex shader
            struct MeshData
            {
                float4 vertex : POSITION;
                float3 normals : NORMAL;
                // float4 tangent : TANGENT;
                // float4 color: COLOR;
                // float4 uv0 : TEXCOORD0; // uv0 diffuse/normal map textures
                // float2 uv1 : TEXCOORD1; // uv1 lightmap coordinates
            };

            // data passed from the vertex shader to the
            // fragment shader
            struct Interpolators
            {
                float4 vertex : SV_POSITION; // clip space position
                float3 normal : TEXCOORD0; // here TEXCOORD0 just means that we are passing data
                // float2 uv : TEXCOORD1;
            };

            Interpolators vertexShader (MeshData meshData)
            {
                Interpolators interpolators;
                interpolators.vertex = UnityObjectToClipPos(meshData.vertex); // local space to clip space
                interpolators.normal = meshData.normals; // just passing mesh data through fragment shader
                return interpolators;
            }

            float4 fragmentShader (Interpolators interpolators) : SV_Target
            {
                return float4(interpolators.normal, 1);
            }
            ENDCG
        }
    }
}
