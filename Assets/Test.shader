Shader "Custom/Test"//this isn't c# it's cg. It is its own language for graphics or something
{
    Properties//변수랑 비슷한 느낌, subshader에서 사용할려면 다시 한번 선언을 해줘야 한다
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }//Opaques render queue index is at 2000. effects have a very high queue index is at the very bottom making it the last thing in the queue
        LOD 200

        CGPROGRAM//this means this is the start of the cg programming
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows//셰이더가 어떤 구조를 갖는지를 설명하는 한 줄, 
														//surface means shader, surf is the function that calculates the surface, 
														//it's using the standard unity lighting, it will use all shadows
			//if i make a new lighting thing then i would need to modify this
			//this one line is veeeeeery important

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0//this means shader model 3.0

        sampler2D _MainTex;//this is a datatype, this is a 재 선언 of the _MainTex in properties, 
						   //sampler2d is used instead of just 2d for using unity's default stuff

        struct Input//surf로 전달되는 입력 구조체이다. 이 입력으로 계산을 할것이다.
        {
            float2 uv_MainTex;
        };

        half _Glossiness;//half means 실수 근데 크기별로 나눈것이다. 효율적인 사용을 위해 크기별로 나눈것이다.
        half _Metallic;//once again these two appeared on properties
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)//크게 중요하지 않음
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)//실제 연산을 해주는 함수, it takes Input and inout.
														   //inout means it can 값을 가져올수도 있고 낼수도 있다.
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
