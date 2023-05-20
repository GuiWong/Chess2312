extends Control


var default_keys = [KEY_ESCAPE,KEY_ENTER,KEY_SPACE,KEY_TAB]

var speed_values = [0.34,0.5,1.0,2.0]
var res_values = [" 480 x 270 " ," 960 x 540 " , "1440 x 810 "]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$HBoxContainer/Button.connect("pressed",read_data)


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
	$Tabs/Controls/Inputs/Overlay/Input_Value.text = OS.get_keycode_string(Inpt.switch[0])
	$Tabs/Controls/Inputs/Active/Input_Value.text = OS.get_keycode_string(Inpt.toggle_ui[0])


func reset_settings():
	
	pass
