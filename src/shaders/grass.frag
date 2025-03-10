#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 pos;
layout(location = 1) in vec4 nor;
layout(location = 2) in vec2 uv;
layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	float d = dot(nor.xyz, normalize(vec3(1,1,1)));
	d = d > 0? d : -0.3 * d;
    outColor = vec4(0.1, 0.5, 0.2, 1.0) * (d * 0.7 + 0.3);
	outColor.w = 1.0;
}
