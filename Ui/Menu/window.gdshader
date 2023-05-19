shader_type canvas_item;

uniform sampler2D dissolve;
uniform float dissolve_ratio;

void fragment() {
	
	COLOR = COLOR * vec4( 0.0, 0.3 , 0.45 , 0.75  );
	//COLOR.a = COLOR.a * dissolve_ratio* 0.75;
	
}
