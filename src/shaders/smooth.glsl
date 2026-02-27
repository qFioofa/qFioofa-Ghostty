#version 330 core

uniform float u_time;
uniform sampler2D u_tex;
in vec2 v_pos;
out vec4 frag_color;

void main() {
    vec2 uv = v_pos * 0.5 + 0.5;
    float wave = sin(uv.y * 10.0 + u_time) * 0.01;
    uv.x += wave;
    vec3 col = texture(u_tex, uv).rgb;
    frag_color = vec4(col, 1.0);
}
