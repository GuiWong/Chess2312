extends Node2D


@export var color = 0
@export var type = 0
var active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Front.self_modulate=Color(1-color,1-color,1-color,1)
	#$Back.self_modulate=Color(color,color,color,1)
	$Back.material.set_shader_parameter("base_color", Color(color,color,color,1))
	$Front.frame_coords.x = type
	$Back.frame_coords.x = type


func toggle_active():
	
	active = not active
		
	$Back.material.set_shader_parameter("active",active)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
