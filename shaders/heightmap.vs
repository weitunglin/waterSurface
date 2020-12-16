#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aNormal;
layout (location = 2) in vec2 aTexCoords;

out vec3 FragPos;
out vec3 Normal;

uniform sampler2D heightmap;
uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;
uniform float time;

float getHeight(vec2 uv) {
    if (uv.x > 1.0) uv.x -= 1.0;
    if (uv.y > 1.0) uv.y -= 1.0;
    return texture(heightmap, uv).r;
}

void main() {
    vec2 uv = aTexCoords + time * vec2(1.0, 0.0) * 0.1;

    vec3 off = vec3(0.01, 0.01, 0.0);
    float height = getHeight(uv);
    float hL = getHeight(uv.xy - off.xz);
    float hR = getHeight(uv.xy + off.xz);
    float hD = getHeight(uv.xy - off.zy);
    float hU = getHeight(uv.xy + off.zy);

    Normal = normalize(vec3(hR - hL, 2.0, hU - hD));

    vec3 pos = vec3(aPos.x, 5 * height, aPos.z);

    FragPos = vec3(model * vec4(pos, 1.0));

    gl_Position = projection * view * model * vec4(pos, 1.0);
}


/*
#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aNormal;
layout (location = 2) in vec2 aTexCoords;

out vec3 FragPos;
out vec3 Normal;

uniform sampler2D heightmap;
uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;
uniform float time;

float getHeight(vec2 uv) {
    return texture(heightmap, uv).r;
}

void main() {
    vec2 uv = aTexCoords + time * vec2(1.0, 0.0) * 0.1;
    vec2 uv1 = vec2(uv.x + 0.01, uv.y);
    vec2 uv1adjuested = vec2(uv.x + 0.01 >= 1.0 ? (uv.x + 0.01 - 1.0) : uv.x + 0.01, uv.y);

    vec2 uv2 = vec2(uv.x, uv.y + 0.01);
    vec2 uv2adjuested = vec2(uv.x, uv.y + 0.01 >= 1.0 ? (uv.y + 0.01 - 1.0) : uv.y + 0.01);

    vec3 height = getHeight(uv);
    vec3 height1 = texture(heightmap, uv1adjuested).rgb;
    vec3 height2 = texture(heightmap, uv2adjuested).rgb;

    vec3 pos = vec3(uv.x, height.x, uv.y);
    vec3 pos1 = vec3(uv1.x, height1.x, uv1.y);
    vec3 pos2 = vec3(uv2.x, height2.x, uv2.y);

    vec3 normal1 = normalize(pos - pos1);
    vec3 normal2 = normalize(pos - pos2);
    Normal = normalize(cross(normal1, normal2));

    pos = vec3(aPos.x, 5 * height.x, aPos.z);

    FragPos = vec3(model * vec4(pos, 1.0));

    gl_Position = projection * view * model * vec4(pos, 1.0);
}
*/