#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#define PI 3.14159265359


void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    float level = 5.0;
    vec3 color = vec3(sin(level*st.x)/2.0+0.7+cos(u_time), sin(level*(st.y+sin(u_time)/3.0))/2.0+0.7+sin(u_time),sin((u_time))/2.0+0.5);
    gl_FragColor = vec4(color,1.0);
}