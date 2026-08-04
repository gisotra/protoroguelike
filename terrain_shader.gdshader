shader_type canvas_item;

uniform sampler2D overlay_tex: repeat_enable, filter_nearest;
uniform float scale = 0.00694444; // calculated by 1/texture size e.g. 1/144
uniform vec4 target_color : source_color = vec4(1.0, 0.0, 0.5, 1.0); // Cor a substituir (ex: rosa)
uniform float tolerance : hint_range(0.0, 1.0) = 0.1; // Tolerância de comparação de cor

varying vec2 world_position;

void vertex(){
	// calculate the world position for use in the fragment shader
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}
void fragment() {
	vec4 original_color = COLOR;
	
	// Só processa se o pixel original não for transparente
	if (original_color.a > 0.0) {
		// Calcula a diferença de cor (RGB)
		float diff = distance(original_color.rgb, target_color.rgb);
		
		// Se a cor estiver dentro da tolerância, substitui 100% pela textura de overlay
		if (diff <= tolerance) {
			vec4 overlay_color = texture(overlay_tex, world_position * scale);
			COLOR = overlay_color;
		} else {
			COLOR = original_color;
		}
	} else {
		COLOR = original_color;
	}
}