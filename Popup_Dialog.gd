extends Control


var can_close = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$Window/Close_button/TextureButton.connect("pressed",$Window.close_anim)
	$Window.connect("close_done",self.close_finish)

func setup(callable,txt,button_txt = "ok"):
	
	$Window/Label.text = txt
	$Window/Button.connect("pressed",callable)
	$Window/Button.text = button_txt
	
func close():
	
	if can_close:
		
		$Window.close()
	
func close_finish():
	
	#if can_close:
		
	queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
