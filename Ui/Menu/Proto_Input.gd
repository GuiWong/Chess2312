extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer2/HBoxContainer/TextureButton.connect("pressed",edit_input)



func edit_input():
	
	InputManager.connect("key_pressed",on_key_validated)
	
func on_key_validated(key):
	
	InputManager.disconnect("key_pressed",on_key_validated)
	
	$VBoxContainer2/HBoxContainer/Label.text = OS.get_keycode_string(key)
	#print(key,OS.get_keycode_string(key))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
