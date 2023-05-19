shader_type canvas_item;
uniform bool active = false;
uniform vec4 base_color : source_color;

void fragment() {
	
	float greenchan = 0.2;
	if (active){
	COLOR = COLOR * vec4(0.0,0.3 + greenchan * sin(TIME * 3.0+ UV.x*8.0 + UV.y*10.0)  ,0.8,1);
	}
	else{
	COLOR = COLOR * base_color;
	}
}
