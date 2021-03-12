shader_type canvas_item;

uniform sampler2D noise;

float random (float time) {
    return fract(sin(time));
}


void fragment() {
	
	vec4 noise_text = texture(noise, UV);
	float value = random(TIME);
	
	if (noise_text.r <= value + 0.05 && noise_text.r >= value - 0.05){
		COLOR = vec4((vec3(1.0) - texture(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb) + noise_text.rgb , abs((texture(TEXTURE, UV).a -1.0)));
	}
	else{
		COLOR = vec4((vec3(1.0) - texture(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb), abs((texture(TEXTURE, UV).a -1.0)));
	}
}
