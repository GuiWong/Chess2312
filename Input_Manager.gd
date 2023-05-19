extends Node

signal focus_move(dir)
signal focus_update
signal validate

signal key_validate

signal target_switch
signal target_next
signal target_prev


signal pause

signal overlay_cycle
signal overlay_toggle
signal choose_overlay( id)
#enum STATE{main_menu,}

signal text_validated

signal popup_confirm_request(pos,callable)

var board_mode = true
var focus = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_focus2():
	
	return Vector2(focus.x,focus.y)
	
func transmit_text_validate():
	
	emit_signal("text_validated")
	
func transmit_pause_closed():
	
	emit_signal("pause")


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode in Inpt.validate:
			emit_signal("key_validate")
		if event.keycode in Inpt.switch:
			emit_signal("target_switch")
		if event.keycode in Inpt.toggle_ui:
			emit_signal("overlay_cycle")
			
		if event.keycode in Inpt.pause:
			emit_signal("pause")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_pos = mouse_pos - get_tree().current_scene.position
	var mouse_tile_pos = floor(mouse_pos / 24)
	
	if focus.z == 0: # Check if mouse in board
		if mouse_tile_pos.x <8 and mouse_tile_pos.y < 8:
		
			if get_focus2() != mouse_tile_pos:
			
				focus = Vector3(mouse_tile_pos.x,mouse_tile_pos.y,0)
				emit_signal("focus_update")
			
		else:
			
			if focus.z == 0:
				focus.z = 1
				emit_signal("focus_update")
			
	else:
		
		if mouse_tile_pos.x <8 and mouse_tile_pos.y < 8:
			focus = Vector3(mouse_tile_pos.x,mouse_tile_pos.y,0)
			emit_signal("focus_update")
			
		
	if Input.is_action_just_pressed("click"):
		
		emit_signal("validate")
