extends Control


var call

var target_size = Vector2(140,70)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#call = self.close
	$Window/VBoxContainer/HBoxContainer/Button.connect("pressed",call)
	$Window/VBoxContainer/HBoxContainer/Button2.connect("pressed",$Window.close_anim)
	$Window.connect("close_done",queue_free)
	$Window.open_anim()
	
	
func setup(call_a):
	
	call = call_a
	#target_size = t_size
	$Window.setup_start_closed(target_size)



func close():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
