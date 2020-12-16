#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;

out vec3 FragPos;
out vec3 Normal;

#define M_PI 3.1415926535897932384626433832795
#define NUMBER_OF_WAVES 2

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform vec4 waves[NUMBER_OF_WAVES];
uniform float time;

vec3 getWave(vec4 wave, vec3 p, inout vec3 tangent, inout vec3 binormal) {
    float steepness = wave.z;
    float wavelength = wave.w;

    float k = 2 * M_PI / wavelength;
    float c = sqrt(9.8 / k);
    vec2 d = normalize(wave.xy);
    float f = k * (dot(d, p.xz) - c * time);
    float a = steepness / k;

    tangent += vec3(
        -d.x * d.x * (steepness * sin(f)),
        d.x * (steepness * cos(f)),
        -d.x * d.y * (steepness * sin(f))
    );

    binormal += vec3(
        -d.x * d.y * (steepness * sin(f)),
        d.y * (steepness * cos(f)),
        -d.y * d.y * (steepness * sin(f))
    );

    return vec3(
        d.x * (a * cos(f)),
        a * sin(f),
        d.y * (a * cos(f))
    );
}

void main() {
    vec3 pos = aPos.xyz;
    
    vec3 tangent = vec3(1.0f, 0.0f, 0.0f);
    vec3 binormal = vec3(0.0f, 0.0f, 1.0f);

    vec3 p = pos;
    p += getWave(waves[0], pos, tangent, binormal);
    p += getWave(waves[1], pos, tangent, binormal);

    Normal = normalize(cross(binormal, tangent));

    FragPos = vec3(model * vec4(p, 1.0));

    gl_Position = projection * view * model * vec4(p, 1.0);
}
