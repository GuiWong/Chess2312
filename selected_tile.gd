extends Node2D

@export var color = Color(1,1,1,1)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.self_modulate=color

func update_color(color_n):
	
	color = color_n
	$Sprite2D.self_modulate=color
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
