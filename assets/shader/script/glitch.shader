shader_type canvas_item;

uniform bool apply = true;
uniform sampler2D displace_texture : hint_albedo;
uniform float dispAmt : hint_range(0, 0.1);
uniform float abbAmt : hint_range(0, 0.1);

void fragment() {
	if(apply){
		//displace effect
		vec4 displace = texture(displace_texture,UV);
//		vec2 newUV = SCREEN_UV + displace.xy * dispAmt;
		vec2 newUV = vec2(SCREEN_UV.x, SCREEN_UV.y - displace.y * dispAmt);
		if (newUV.x <= 0.5){
			newUV.x = newUV.x + displace.x * dispAmt;
		} 
		else{
			newUV.x = newUV.x - displace.x * dispAmt; 
		}
	
		//abberation effect
		COLOR.r = texture(SCREEN_TEXTURE, vec2(newUV.x - abbAmt, newUV.y)).r;
		COLOR.g = texture(SCREEN_TEXTURE, vec2(newUV.x, newUV.y - abbAmt)).g;
		COLOR.b = texture(SCREEN_TEXTURE, vec2(newUV.x + abbAmt, newUV.y)).b;
		COLOR.a = texture(SCREEN_TEXTURE, newUV).a;
	}
	else{
		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	}
}