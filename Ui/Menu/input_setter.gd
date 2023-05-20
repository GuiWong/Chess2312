extends HBoxContainer

@export var input_name ="Pause / Exit"
var key_code_stored = KEY_ESCAPE
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Input_Name.text = input_name
	$Set_Input.connect("pressed",start_listening)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_listening():
	
	InputManager.connect("key_pressed", set_key)
	
func set_key(key):
	
	InputManager.disconnect("key_pressed", set_key)
	key_code_stored = key
	$Input_Value.text = OS.get_keycode_string(key)
