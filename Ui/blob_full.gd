extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func build(dir_mask):
	
	for d in range(8):
		
		if dir_mask & 1 << d > 0:
			
			$Node2D.get_child(d).visible=true
			
		else:
			
			$Node2D.get_child(d).visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
