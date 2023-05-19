extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	connect("child_entered_tree",activate)
	connect("child_exiting_tree",disable)


func activate(node):
	
	mouse_filter=Control.MOUSE_FILTER_STOP
	
func disable(node):
	
	if get_child_count() <= 1:
		mouse_filter=Control.MOUSE_FILTER_IGNORE
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
