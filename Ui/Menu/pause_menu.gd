extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Window/Close_button/TextureButton.connect("pressed",InputManager.transmit_pause_closed)
	$Window/VBoxContainer/Button.connect("pressed",InputManager.transmit_pause_closed)
	$Window/VBoxContainer/Button4.connect("pressed",main_menu)
	$Window/VBoxContainer/Button3.connect("pressed",quit)
	
	$Window.connect("close_done",close)



func close():
	
	visible = false

func main_menu():
	
	var pos = $Window/VBoxContainer/Button4.global_position + $Window/VBoxContainer/Button4.size/2 - Vector2(70,35)
	InputManager.emit_signal("popup_confirm_request",pos,SceneManager.load_main_menu)
	#TODO let The game Handle quiting to menu
	
func quit():
	
	var pos = $Window/VBoxContainer/Button3.global_position + $Window/VBoxContainer/Button3.size/2 - Vector2(70,35)
	InputManager.emit_signal("popup_confirm_request",pos,get_tree().quit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
