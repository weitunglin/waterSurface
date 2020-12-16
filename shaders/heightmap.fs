#version 330 core
out vec4 FragColor;

in vec3 Normal;
in vec3 FragPos;

uniform vec3 viewPos;
uniform samplerCube skybox;

void main()
{    
    float ratio = 1.00 / 1.52;
    vec3 I = normalize(FragPos - viewPos);
    vec3 result = vec3(0.0);
    result += texture(skybox, reflect(I, normalize(Normal))).rgb;
    result += texture(skybox, refract(I, normalize(Normal), ratio)).rgb;
    FragColor = vec4(result, 0.0);
    // FragColor = vec4(0.0, 0.0, 1.0, 1.0);
}
