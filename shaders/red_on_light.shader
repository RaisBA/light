shader_type canvas_item;

void fragment(){
	COLOR = texture(TEXTURE, UV);
	COLOR.a = min(COLOR.a, 0.7);
	
	if (AT_LIGHT_PASS && COLOR.a > 0.0) {
		COLOR.rgb = texture(TEXTURE, UV).rgb * vec3(2, 0, 0);
	} 
}