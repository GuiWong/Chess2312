shader_type canvas_item;

void fragment() {
	//COLOR = COLOR * vec4(0.2 + 0.5 * sin(TIME * 3.0 + UV.y* 2.0) , 0.5 * sin(TIME * 3.0 + UV.x* 2.0),0.5 + 0.2 * (sin((TIME +PI ) * 3.0)  ),1.0);
	//COLOR = COLOR * vec4(0.2 + 0.5 * sin(TIME * 3.0 + UV.y* 12.0) , 0.5 * sin(TIME * 5.0 + UV.x* 4.0),0.4 + 0.3,1.0);
	COLOR = COLOR * vec4(0.2 + 0.5 * (sin(TIME * 3.0 + UV.y* 2.0) + 1.0 ), 0.5 * ( sin(TIME * 3.0 + UV.x* 2.0) + 1.0 ),0.5 + 0.5 * ( sin((TIME + PI/2.0 ) * 3.0) + 1.0  )  ,1.0);
}
