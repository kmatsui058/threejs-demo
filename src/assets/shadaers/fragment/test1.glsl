#ifdef GL_ES
precision mediump float;
#endif


void main() {
	vec2 position = gl_FragCoord.xy/iResolution.x;
	vec2 mouse = iMouse.xy/iResolution.x;
	float color;
	if (distance(position, mouse) < 0.1) {
		color = 1.0;
	} else {
		color = 0.0;
	}
	gl_FragColor = vec4(color,color,color,1.0);
}