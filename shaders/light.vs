#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;

out vec3 FragPos;
out vec3 Normal;
out vec2 TexCoords;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform vec2 direction;
uniform float amplitude;
uniform float wavelength;
uniform float speed;
uniform float time;

#define M_PI 3.1415926535897932384626433832795

float wave(float x, float y) {
    float f = 2 * M_PI * wavelength;
    float phase = speed * f;
    float theta = dot(direction, vec2(x, y));
    return amplitude * sin(theta * f + time * phase);
}

float waveHeight(float x, float y) {
    float height = 0.0;
    height += wave(x, y);
    return height;
}

float dWavedx(float x, float y) {
    float f = 2 * M_PI * wavelength;
    float phase = speed * f;
    float theta = dot(direction, vec2(x, y));
    float A = amplitude * direction.x * f;
    return A * cos(theta * f + time * phase);
}

float dWavedy(float x, float y) {
    float f = 2 * M_PI * wavelength;
    float phase = speed * f;
    float theta = dot(direction, vec2(x, y));
    float A = amplitude * direction.y * f;
    return A * cos(theta * f + time * phase);
}

vec3 waveNormal(float x, float y) {
    float dx = 0.0;
    float dy = 0.0;
    dx += dWavedx(x, y);
    dy += dWavedy(x, y);
    vec3 n = vec3(-dx, 1.0, -dy);
    return normalize(n);
}

void main()
{
    vec3 p = aPos;
    
    p.y = waveHeight(p.x, p.z);
    vec3 normal = waveNormal(p.x, p.z);
    Normal = mat3(transpose(inverse(model))) * aNormal;

    FragPos = vec3(model * vec4(p, 1.0));
    TexCoords = aTexCoords;

    vec4 pos = projection * view * vec4(FragPos, 1.0);

    gl_Position = pos.xyzw;
}
