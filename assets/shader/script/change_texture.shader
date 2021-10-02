shader_type canvas_item;

uniform float progress : hint_range(0, 1.1);
uniform sampler2D noise;
uniform sampler2D next; //setted by code


void fragment()
{
	vec4 text = texture(TEXTURE, UV);
	vec4 noise_text = texture(noise, UV);
	vec4 next_text = texture(next, UV);
	vec3 color = text.rgb*0.5;
	
	
	
	float d1 = step(progress, noise_text.r);
	float d2 = step(progress - 0.1, noise_text.r);
	
	vec3 beam = vec3(d2 - d1) * color;
	
	text.rgb += beam;
	text.a *= d2;
	
	if(text.a <= 0.0){
		text = next_text;
	}
	COLOR = text;
}