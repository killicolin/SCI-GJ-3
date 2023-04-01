shader_type canvas_item;

uniform sampler2D noise;
uniform float filter = 0.5;
uniform float fps = 12.0;
uniform float size = 7;
float get_noise(float time, vec2 uv){
	vec2 ofs = vec2(sin(41.0 * time * sin(time * 123.0)), sin(27.0 * time * sin(time * 312.0)));
	return texture(noise, (uv + ofs)/size).r;
}

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

void fragment() {
//	vec2 st = vec2(sin(41.0 * TIME * sin(TIME * 123.0)), sin(27.0 * TIME * sin(TIME * 312.0)))*SCREEN_UV;
//	vec3 test =vec3(float(random(st) > 0.9));
//	vec3 screen = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;
//	COLOR.rgb = screen+test;
	vec3 screen = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;
	float f = 1.0 / fps;
	float noiseValue= get_noise((TIME- mod(TIME, f)),SCREEN_UV);
	noiseValue = max(noiseValue, get_noise(TIME - mod(TIME, f) + f, UV) * 0.5);
	noiseValue = max(noiseValue, get_noise(TIME - mod(TIME, f) + f * 2.0, UV) * 0.25);
	//float v = max(c.r, max(c.g, c.b));
	COLOR.rgb =screen+ vec3(float(noiseValue>filter));
}