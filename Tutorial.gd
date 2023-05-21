extends "res://game.gd"


signal proceed

var wait_for_action = false

func step_tutorial(step):		#return true if need to wait
	
	$Tuto_Ui/Tuto_Arrow.scale = Vector2(1,1)
	
	#if current_turn == 0:
		
	#	state = STATE.pause
	#	create_dialog_popup(on_text_validate,"you finished tutorial","quit to menu")
		
	if current_turn == 10:
		
		#print("tutorial finished")
		state = STATE.pause
		create_dialog_popup(SceneManager.load_main_menu,"you finished tutorial","quit to menu")
		return true
	
	#----------------- arrow logic ------------------
	
	if step == 1 or step == 2:
		
		if $Tutorial_Dialogs.pos_limits[current_turn][step - 1] != null:
			
			$Tuto_Ui/Tuto_Arrow.position = $Tutorial_Dialogs.pos_limits[current_turn][step - 1] * 24 
			
		else:
			
			$Tuto_Ui/Tuto_Arrow.position= Vector2(-400,-400)
			
	if $Tutorial_Dialogs.skip_rule[current_turn][step] == 2:
		
		if current_turn == 1:
			
			$Tuto_Ui/Tuto_Arrow.position= $Visual_Interface/Button_banner/Pattern_mode_toggle.global_position
			
		elif current_turn == 3:
			
			$Tuto_Ui/Tuto_Arrow.position= $Visual_Interface/Button_banner/Color_mode_toggle.global_position
			
	if current_turn == 7 and step == 2:
		
		$Tuto_Ui/Tuto_Arrow.position= $Visual_Interface/Button_banner/Toggle_Effect.global_position
	
	if $Tutorial_Dialogs.skip_rule[current_turn][step] == 1:
			
			$Tuto_Ui/Tuto_Arrow.position = Vector2(458,224)
			$Tuto_Ui/Tuto_Arrow.scale = Vector2(-1,1)
			
	
		
	if step == 2:
			
		if current_turn == 3:
			$Tuto_Ui/Tuto_Arrow.scale = Vector2(-1,-1)
		if current_turn == 8:
			$Tuto_Ui/Tuto_Arrow.scale = Vector2(1,-1)
	if current_turn in [5,6,8] and step == 1:
			
		$Tuto_Ui/Tuto_Arrow.scale = Vector2(-1,-1)
			
			
	#---------- Text and proceed logic ----------------
			
	
	if $Tutorial_Dialogs.lines[current_turn][step] != null:
		
		write_text($Tutorial_Dialogs.lines[current_turn][step])
		
		if $Tutorial_Dialogs.skip_rule[current_turn][step] == 1:
			
			return true
			
		elif $Tutorial_Dialogs.skip_rule[current_turn][step] == 2:
			
			wait_for_action = true
			return true
			
		else:
			
			return false
		
		
	else:
		
		return false

func new_game():
	
	InputManager.disconnect("key_validate",on_validate)
	InputManager.connect("key_validate",close_dialog_box)
	var t_list = []
	var c = 0
	
	t_list.append(piece_dat.new(0,piece_dat.TYPE.PAWN))
	t_list.append(piece_dat.new(1,piece_dat.TYPE.TOWER))
	t_list.append(piece_dat.new(0,piece_dat.TYPE.HORSE))
	t_list.append(piece_dat.new(1,piece_dat.TYPE.PAWN))
	t_list.append(piece_dat.new(0,piece_dat.TYPE.BISHOP))
	t_list.append(piece_dat.new(1,piece_dat.TYPE.PAWN))
	
	t_list.append(piece_dat.new(0,piece_dat.TYPE.QUEEN))
	t_list.append(piece_dat.new(0,piece_dat.TYPE.PAWN))
	t_list.append(piece_dat.new(1,piece_dat.TYPE.PAWN))
	t_list.append(piece_dat.new(0,piece_dat.TYPE.KING))
		
		
	piece_list = t_list
	
	current_turn=-1
	
	#create_dialog_popup(on_text_validate,"TUTO_POPUP1","quit to menu")
	
	
	
func new_turn():
	
	if current_turn == -1:
		create_text_popup($Tutorial_Dialogs.temp_line)
		state =STATE.waiting
		await text_popup_was_closed
	
		create_text_popup($Tutorial_Dialogs.line_2)
		state =STATE.waiting
		await text_popup_was_closed
			
	
	current_turn += 1
	$Visual_Interface.update_turn_counter(current_turn)
	
	
	if step_tutorial(0):
	
		await proceed
	
func draw_piece():
	
	
	state = STATE.place
	
	
	
	$Visual_Interface.draw_piece(piece_list[0].color,piece_list[0].type)
	
	

	current_piece = piece_list[0]
	
	piece_list.remove_at(0)
	
	
	step_tutorial(1)
	#await proceed
	
func on_overlay_cycle():
	
	super.on_overlay_cycle()
		
func set_overlay(x):
	
	super.set_overlay(x)
	
func update_overlay(old):
	
	super(old)
	if current_turn == 1 and active_overlay == 1 and wait_for_action:
		
		emit_signal("proceed")
		wait_for_action = false
		
	if current_turn == 3 and active_overlay == 2 and wait_for_action:
		
		emit_signal("proceed")
		wait_for_action= false
	
func on_validate():
	
	var place_pos = $Tutorial_Dialogs.pos_limits[current_turn][0]
	var effect_pos = $Tutorial_Dialogs.pos_limits[current_turn][1]
	
	#if place_pos == Vector2(-1,-1)
	
	
	if mouse_in_board: #check formouse in board
		if state == STATE.place:
			
			if place_pos == null:
				if $Board.can_play(InputManager.get_focus2()):
			
					place_piece(InputManager.get_focus2())
			else:
				
				if InputManager.get_focus2()== place_pos:
					
					place_piece(InputManager.get_focus2())
			#$Board.play_piece(current_piece,InputManager.get_focus2())
		elif state == STATE.solve:
			
			
			if effect_pos == null:
				
				if InputManager.get_focus2() in effect_queue[active_effect_index].target_list:
			
					solve_effect(InputManager.get_focus2())
			
			else:
				
				if InputManager.get_focus2() == effect_pos:
					
					solve_effect(InputManager.get_focus2())
					
func place_piece(pos):
	
	var returned_piece = $Board.get_piece(pos) #get piece if replacement occurs
		
	if returned_piece != null:
		
		piece_list.append(returned_piece)
		$Visual_Interface.remove_piece(pos)
	
	var effects = $Board.play_piece(current_piece,pos)
	
	$Visual_Interface.play_piece(pos)
	
	$Visual_Interface.remove_playable_tile()
	$Visual_Interface.remove_effected_tile()
	
	if step_tutorial(2):
		state = STATE.waiting
		await proceed
		
		if current_turn == 9:
			
			effects = []
			end_turn()
		
	
	if effects.size()>0:
		
		if effects.size()>1:		#check if more than 1 effect to update effect button
			$Visual_Interface/Button_banner.update_effect_button(false)
		
		state = STATE.solve
		effect_queue = effects
		save_effect_entities()
		effect_locked = []
		locked_count = 0
		for e in effects:
			effect_locked.append(0)	#Reset locked effects when starting
		select_effect(0)
		
	else:
		
		end_turn()
		

	
func end_turn():
	
	$Visual_Interface/Button_banner.update_effect_button(true)		#disable effect button until reactivated
	
	update_score()
	
	$Visual_Interface.reset_score()
	$Visual_Interface.build_score()
	
	if step_tutorial(3):
		state = STATE.waiting
		await proceed
	
	await new_turn()	
	
	if piece_list.size() >= 1:
		draw_piece()
		show_playable(current_piece.color)
	else:
		
		end_game()
	
func close_dialog_box():
	
	if not popup_text_present:
		emit_signal("proceed")

