Shader "Unlit/S_Unlit_UV_Gradient"
{
    Properties
    {
        _ColorA ("Color A", Color) = (1,0,0,1)
        _ColorB ("Color B", Color) = (0,0,1,1)
        _ColorStart ("Color Start", Range(0,1)) = 0
        _ColorEnd ("Color End", Range(0,1)) = 1
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

            float4 _ColorA;
            float4 _ColorB;
            float _ColorStart;
            float _ColorEnd;

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

            float InverseLerp(float a, float b, float v)
            {
                return (v - a) / (b - a);
            }

            float4 fragmentShader (Interpolators interpolators) : SV_Target
            {
                float t = InverseLerp(_ColorStart, _ColorEnd, interpolators.uv.x);
                // return _ColorA + saturate(t) * (_ColorB - _ColorA);
                return lerp(_ColorA, _ColorB, saturate(t)); // saturate(v) == Mathf.Clamp01(v)
            }
            ENDCG
        }
    }
}
