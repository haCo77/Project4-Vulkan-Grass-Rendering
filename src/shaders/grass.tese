#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0[];
layout(location = 1) in vec4 v1[];
layout(location = 2) in vec4 v2[];
layout(location = 3) in vec4 up[];
layout(location = 0) out vec4 pos;
layout(location = 1) out vec4 nor;
layout(location = 2) out vec2 uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	uv = vec2(u, v);
	vec3 p = v0[0].xyz + v * (v1[0].xyz - v0[0].xyz);
	vec3 q = v1[0].xyz + v * (v2[0].xyz - v1[0].xyz);
	vec3 m = p + v * (q - p);
 	vec3 dir = vec3(sin(v0[0].w), 0.0, cos(v0[0].w));
	vec3 l = m - v2[0].w * dir;
	vec3 r = m + v2[0].w * dir;
	nor.xyz = normalize(cross(up[0].xyz, dir));
	float t = u + 0.5 * v - u * v;
	pos.xyz =  mix(l, r, t);
	gl_Position = camera.proj * camera.view * vec4(pos.xyz, 1.0);
}
