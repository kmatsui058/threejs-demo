#ifdef GL_ES
precision mediump float;
#endif
uniform vec2 u_resolution;
uniform vec2 u_mouse;  
uniform float u_time;

void main() {
	vec2 position = gl_FragCoord.xy/u_resolution.x;
	vec2 mouse = u_mouse.xy/u_resolution.x;
	float color;
	if (distance(position, mouse) < 0.1) {
		color = 1.0;
	} else {
		color = 0.0;
	}
	gl_FragColor = vec4(color,color,color,1.0);
}