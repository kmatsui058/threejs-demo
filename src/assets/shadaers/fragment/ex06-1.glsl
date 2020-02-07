#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

#define PI 3.14159265359
vec3 colorA = vec3(0.9137, 0.1412, 0.2431);
vec3 colorB = vec3(1.000,0.833,0.224);

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec3 pct = vec3(st.y);

    // pct.r = smoothstep(0.0,1.0, st.x);
    // pct.g = sin(st.x*PI);
    // pct.b = pow(st.x,0.5);

    color = mix(colorA, colorB, pct);


    gl_FragColor = vec4(color,1.0);
}