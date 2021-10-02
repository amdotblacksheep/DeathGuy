shader_type canvas_item;

uniform float progress : hint_range(0, 1.2);
uniform vec4 color : hint_color = vec4(1.5, 1.5, 1.5, 1.0);
uniform sampler2D noise;

void fragment()
{
	vec4 text = texture(TEXTURE, UV);
	vec4 noise_text = texture(noise, UV);
	
	float d1 = step(progress, noise_text.r);
	float d2 = step(progress - 0.2, noise_text.r);
	
	vec3 beam = vec3(d2 - d1) * color.rgb;
	
	text.rgb += beam;
	text.a *= d2;
	

	COLOR = text;
}