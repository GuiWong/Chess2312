shader_type canvas_item;

void fragment() {
	float greenchan = 0.2;
	
	COLOR = COLOR * vec4(0.0,0.3 + greenchan * sin(TIME * 2.0+ UV.x *165.0 + UV.y*110.0)  ,0.8,1);
}
