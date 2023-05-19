extends Node

var up = [KEY_W,KEY_UP]
var left = [KEY_A,KEY_LEFT]
var down = [KEY_S,KEY_DOWN]
var right = [KEY_D,KEY_RIGHT]

var validate = [KEY_ENTER]
var pause = [KEY_ESCAPE]

var switch = [KEY_TAB]
var next = [null]
var prev = [null]

var toggle_ui = [KEY_SPACE]


var up_joy = JOY_BUTTON_DPAD_UP
var left_joy = JOY_BUTTON_DPAD_LEFT
var down_joy = JOY_BUTTON_DPAD_DOWN
var right_joy = JOY_BUTTON_DPAD_RIGHT

var validate_joy = JOY_BUTTON_A
var pause_joy = JOY_BUTTON_START

var switch_joy = JOY_BUTTON_X
var next_joy = JOY_BUTTON_RIGHT_SHOULDER
var prev_joy = JOY_BUTTON_LEFT_SHOULDER





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func load_preset_qwert():
	
	up[0] = KEY_W
	left[0] = KEY_A
	
func load_preset_azert():
	
	up[0] = KEY_Z
	left[0] = KEY_Q

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
