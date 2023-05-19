extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(8):
		for y in range(8):
			var s3d =Sprite3D
			#s


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Pivot.rotate_y(0.2 * delta)
