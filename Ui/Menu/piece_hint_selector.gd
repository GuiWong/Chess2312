extends TextureButton


@export var id = 0
signal selected(id)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	#placeholder
	texture_normal.region.position.x = id * 16
	connect("pressed",on_button)

func set_id(new_id):
	
	id = new_id
	
	texture_normal.region.x = id * 16
	
func on_button():
	
	emit_signal("selected",id)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
