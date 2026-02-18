shader_type canvas_item;

void vertex() {
	if( VERTEX.x < 0.0 &&  VERTEX.y < 0.0){
		//VERTEX += vec2((sin(TIME * 10.0) * 20.0 + 1.0)/ 2.0, (cos(TIME * 10.0) * 20.0 + 1.0) / 2.0);
	}

}

void fragment() {

	vec4 newColor = vec4(UV.x, UV.y, 0.2, 0);
	newColor.b += (sin(TIME * 5.0) * 1.5 + 1.0 ) / 2.0;
	COLOR = texture(TEXTURE, UV) + newColor;

}
