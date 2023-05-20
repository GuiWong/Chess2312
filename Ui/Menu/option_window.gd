extends Control


var default_keys = [KEY_ESCAPE,KEY_ENTER,KEY_SPACE,KEY_TAB]

#var stored_keys = [KEY_ESCAPE,KEY_ENTER,KEY_SPACE,KEY_TAB]

var speed_values = [0.34,0.5,1.0,2.0]
var res_values = [" 480 x 270 " ," 960 x 540 " , "1440 x 810 "]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#$HBoxContainer/Button.connect("pressed",read_data)
	
	$HBoxContainer/Button2.connect("pressed",apply_data)
	#$Tabs/Controls/Inputs/Active.key_code_stored = default_keys[3]
	#$Tabs/Controls/Inputs/Active.key_code_stored = default_keys[3]
	#$Tabs/Controls/Inputs/Active.key_code_stored = default_keys[3]
	#$Tabs/Controls/Inputs/Active.key_code_stored = default_keys[3]
	
	read_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func read_data():
	


	#print($Tabs/Game/text_speed/Option_Line/OptionButton.selected)
	$Tabs/Game/text_speed/Value_Line/Speed_Value.text = str(speed_values.find(MySettings.text_speed))
	
	#$Tabs/Game/text_speed/Option_Line/OptionButton.selected = 2
	$Tabs/Graphic/VBoxContainer/HBoxContainer/Resolution_Value.text = res_values[get_tree().root.content_scale_factor -1]

	$Tabs/Controls/Inputs/Pause/Input_Value.text = OS.get_keycode_string(Inpt.pause[0])
	$Tabs/Controls/Inputs/Validate/Input_Value.text = OS.get_keycode_string(Inpt.validate[0])
	$Tabs/Controls/Inputs/Overlay/Input_Value.text = OS.get_keycode_string(Inpt.toggle_ui[0])
	$Tabs/Controls/Inputs/Active/Input_Value.text = OS.get_keycode_string(Inpt.switch[0])
	
	$Tabs/Controls/Inputs/Pause.key_code_stored = Inpt.pause[0]
	$Tabs/Controls/Inputs/Validate.key_code_stored = Inpt.validate[0]
	$Tabs/Controls/Inputs/Overlay.key_code_stored = Inpt.toggle_ui[0]
	$Tabs/Controls/Inputs/Active.key_code_stored = Inpt.switch[0]
	
func apply_data():
	
	
	Inpt.switch[0] = $Tabs/Controls/Inputs/Active.key_code_stored
	Inpt.pause[0] = $Tabs/Controls/Inputs/Pause.key_code_stored
	Inpt.validate[0] = $Tabs/Controls/Inputs/Validate.key_code_stored
	Inpt.toggle_ui[0] = $Tabs/Controls/Inputs/Overlay.key_code_stored
	
	get_tree().root.content_scale_factor = $Tabs/Graphic/VBoxContainer/Option_Line2/OptionButton.selected + 1
	MySettings.text_speed = speed_values[$Tabs/Game/text_speed/Option_Line/OptionButton.selected]
	
	get_window().size = Vector2(480,270) * get_tree().root.content_scale_factor
	
	read_data()

func reset_settings():
	
	Inpt.switch[0] = default_keys[3]
	Inpt.pause[0] = default_keys[0]
	Inpt.validate[0] = default_keys[1]
	Inpt.toggle_ui[0] = default_keys[2]
	MySettings.text_speed = 1.0
