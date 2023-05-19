extends Control


# Called when the node enters the scene tree for the first time.

var updating = false

func _ready():
	
	#TODO: BETTER DESIGN
	
	$Color_mode_toggle/TextureButton.connect("toggled",pass_color_toggle)
	$Pattern_mode_toggle/TextureButton.connect("toggled",pass_pattern_toggle)
	$Toggle_Overlay/TextureButton.connect("toggled",pass_overlay_toggle)
	$Pause_Button/TextureButton.connect("pressed",pass_pause)
	$Toggle_Effect/TextureButton.connect("pressed",pass_effect_cycle)
	
func update_effect_button(state):
	
	$Toggle_Effect/TextureButton.disabled = state
	

func update_states(tog,new):
	
	updating = true
	if tog:
		
		$Toggle_Overlay/TextureButton.button_pressed =true
		
	else:
		
		$Toggle_Overlay/TextureButton.button_pressed = false
		
	if new == 0:
		
		$Color_mode_toggle/TextureButton.button_pressed = false
		$Pattern_mode_toggle/TextureButton.button_pressed = false
		
	elif new == 1:

		$Pattern_mode_toggle/TextureButton.button_pressed = true
		$Color_mode_toggle/TextureButton.button_pressed = false
		
	elif new == 2:
		
		$Color_mode_toggle/TextureButton.button_pressed = true
		$Pattern_mode_toggle/TextureButton.button_pressed = false
		
	updating = false
		
		
	
func debug_input(evnt):
	
	print(evnt)
	
func pass_overlay_toggle(stat):
	if not updating:
		InputManager.emit_signal("overlay_toggle")
		
func pass_color_toggle(stat):
	
	if not updating:
		InputManager.emit_signal("choose_overlay",2)
	
func pass_pattern_toggle(stat):
	
	if not updating:
		
		InputManager.emit_signal("choose_overlay",1)
		
func pass_effect_cycle():
	
	if not updating:
		
		InputManager.emit_signal("target_switch")
		
func pass_pause():
	
	if not updating:
		
		InputManager.emit_signal("pause")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
