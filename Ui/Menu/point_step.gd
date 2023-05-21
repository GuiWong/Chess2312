extends Node2D

@export var type = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Sprite2D.frame = type


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
