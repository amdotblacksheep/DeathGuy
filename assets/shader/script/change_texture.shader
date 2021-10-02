shader_type canvas_item;

uniform float value : hint_range(0, 1);
uniform sampler2D erease_texture;
uniform sampler2D next_texture;

void fragment()
{
	vec4 out_color = texture(TEXTURE, UV);
	vec4 sampler = texture(erease_texture, UV);
	
	if(sampler.r > value){
		COLOR = texture(next_texture, UV);
	}
	else{
		COLOR = out_color
	}
}