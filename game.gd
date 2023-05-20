extends Node2D


var piece_list = []
var current_piece
var current_turn

var piece_dat = preload("res://piece_data.gd")
var effect_dat = preload("res://Effect.gd")

enum STATE{place,solve,pause,finished,waiting}
var state = STATE.place
var stored_state = STATE.place

var effect_queue = []
var effectors_entity = []
var active_effect_index = 0
var effect_locked = []
var locked_count = 0

var overlay_on = false
var active_overlay = 0
var overlay_count = 2


var mouse_in_board = false

var popup_text_present = false

signal text_popup_was_closed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
	InputManager.connect("validate",self.on_validate)
	
	InputManager.connect("key_validate",self.on_validate)
	
	InputManager.connect("target_switch",self.on_target_switch)
	InputManager.connect("focus_update",self.on_focus_update)
	
	#$Visual_Interface.show_move_arrow(Vector2(3,3),Vector2(3,2))
	#$Visual_Interface.show_move_arrow(Vector2(3,3),Vector2(3,4))
	InputManager.connect("overlay_cycle",self.on_overlay_cycle)
	InputManager.connect("choose_overlay",self.set_overlay)
	InputManager.connect("overlay_toggle",self.toggle_overlays_visible)
	InputManager.connect("text_validated",self.on_text_validate)
	InputManager.connect("pause",self.on_pause)
	#$Visual_Interface.show_move_arrow(Vector2(3,3),Vector2(4,3))
	
	InputManager.connect("popup_confirm_request",self.create_popup)
	InputManager.connect("text_popup_confirm",self.on_popup_sent_done)
	
	begin_game()
	
func begin_game():
	
	new_game()
	await new_turn()
	await draw_piece()
	show_playable(current_piece.color)
	
func test_input():
	
	#print("focus changed " + str(InputManager.focus.x) + ";" + str(InputManager.focus.x))
	#print("coucou")
	#print ($Board.get_adj_effects(InputManager.get_focus2()))
	place_piece(InputManager.get_focus2())
	#print ($Board.can_play(InputManager.get_focus2()))
	

func new_game():
	
	var t_list = []
	var c = 0
	while c <= 1:
		for i in range(8):
			t_list.append(piece_dat.new(c,0))
		for j in range(4):
			t_list.append(piece_dat.new(c,j/2+1))
		for k in range(2):
			t_list.append(piece_dat.new(c,5))
		t_list.append(piece_dat.new(c,3))
		t_list.append(piece_dat.new(c,4))
		c +=1
		
	piece_list = t_list
	
	current_turn=-1
	

func new_turn():
	
	current_turn += 1
	$Visual_Interface.update_turn_counter(current_turn)
	
func draw_piece():
	
	
	state = STATE.place
	
	var i = randi_range(0,piece_list.size()-1)
	#var c = piece.instantiate()
	#c.color= piece_list[i].color
	#c.type = piece_list[i].type
	
	
	$Visual_Interface.draw_piece(piece_list[i].color,piece_list[i].type)
	
	

	current_piece = piece_list[i]
	
	piece_list.remove_at(i)
	
func show_playable(c):
	
	var first = false
	var replace = false
	if current_turn == 0:
		first = true
	if current_piece.type == piece_data.TYPE.KING:
		
		replace = true
		
		
		
	var listed = $Board.get_playable_tile(current_piece.color,replace,first)
	$Visual_Interface.build_playable_tile(listed)
	
	
	
#-----------TODO: all on_input functions

#-----------TODO: cases for state
#-----------TODO: pre_process focus2 to avoid out of board issues
#-----------TODO: 

func old_overlay_cycle():
	
	if overlay_on:
		
		if active_overlay == 0:
			
			active_overlay = 1
			$Visual_Interface.show_color_groups()
			$Visual_Interface.hide_score()
			
		elif active_overlay == 1:
			
			overlay_on = false
			active_overlay = 0
			
			$Visual_Interface.hide_color_groups()
		
	else:
		
		overlay_on = true
		$Visual_Interface.show_score()
		
	#ui_on= not ui_on
	
func on_text_validate():
	
	if $Visual_Interface/Text_Box/Text_Box_2.state == $Visual_Interface/Text_Box/Text_Box_2.STATE.done:
		close_dialog_box()
	else:
		print("text not finished")

func on_overlay_cycle():
	
	var old = active_overlay
	if not overlay_on:
		
		overlay_on = true
		
		if active_overlay == 0:
			
			active_overlay = 1
			
	else:
		
		active_overlay += 1
		if active_overlay > overlay_count:
			active_overlay = 0
			overlay_on = false
			
	update_overlay(old)
		
func set_overlay(x):
	
	var old = active_overlay
	if not overlay_on:
		
		overlay_on= true
		active_overlay = x
		
	else:
		
		if active_overlay == x:
			overlay_on = false
		else:
			active_overlay = x
			
	update_overlay(old)
	
func toggle_overlays_visible():
	
	overlay_on = not overlay_on
	
	$Visual_Interface.set_overlays_visible(overlay_on)
	
	$Visual_Interface/Button_banner.update_states(overlay_on,active_overlay )
			
func update_overlay(old):
	
	#print("ovelay: " + str(overlay_on) + "  number: " + str(active_overlay))
	
	$Visual_Interface.set_overlays_visible(overlay_on)
	$Visual_Interface.set_overlay_layer_visible(old,false)
	$Visual_Interface.set_overlay_layer_visible(active_overlay,true)
	
	$Visual_Interface/Button_banner.update_states(overlay_on,active_overlay   )

func on_focus_update():
	
	
	if state != STATE.pause:		#check to only update if not paused
		
		$Visual_Interface.remove_effected_tile()
		$Visual_Interface.move_selector(InputManager.get_focus2())
	
		if InputManager.focus.z == 0: #check that focus is in board
		
			mouse_in_board = true
		
			if $Board.can_play(InputManager.get_focus2()):
			#print("playable tile")
				$Visual_Interface.build_effected_tile($Board.get_adj_effects(InputManager.get_focus2()))
			if state == STATE.solve:
				if InputManager.get_focus2() in effect_queue[active_effect_index].target_list:
					$Visual_Interface.show_move_arrow(effect_queue[active_effect_index].author,InputManager.get_focus2())
				else:
					$Visual_Interface.hide_move_arrow()
					
		else:
			
			mouse_in_board = false
				
			
func on_target_switch():
	
	if state== STATE.solve:
		$Visual_Interface.remove_playable_tile()
		$Visual_Interface.reset_active_piece()
		$Visual_Interface.hide_move_arrow()
		next_target()
	
func next_target():
	
	select_effect( (active_effect_index + 1) % effect_queue.size())
	
func prev_target():
	
	select_effect((active_effect_index - 1) % effect_queue.size())
	
func on_validate():
	
	
	if mouse_in_board: #check formouse in board
		if state == STATE.place:
			if $Board.can_play(InputManager.get_focus2()):
			
				place_piece(InputManager.get_focus2())
			#$Board.play_piece(current_piece,InputManager.get_focus2())
		elif state == STATE.solve:
			
			if InputManager.get_focus2() in effect_queue[active_effect_index].target_list:
			
				solve_effect(InputManager.get_focus2())
				#state == STATE.place
				
func on_pause():
	
	if state == STATE.pause:
		
		state = stored_state
		$UI/Pause_Menu/Window.close_anim()
		$UI/Pause_Menu/Window.close_done
		#$UI/Pause_Menu.visible = false
		
	else:
		
		stored_state = state
		state = STATE.pause
		$UI/Pause_Menu.visible = true
		$UI/Pause_Menu/Window.open_anim()
		
func on_popup_sent_done():
	
	close_text_popup()

func save_effect_entities():
	
	var list = []
	for e in effect_queue:
		
		list.append($Board.get_piece(e.author))
		
	effectors_entity = list
	
	#print(effectors_entity)

func place_piece(pos):
	
	var returned_piece = $Board.get_piece(pos) #get piece if replacement occurs
		
	if returned_piece != null:
		
		piece_list.append(returned_piece)
		$Visual_Interface.remove_piece(pos)
	
	var effects = $Board.play_piece(current_piece,pos)  #return activated tiles
	
	$Visual_Interface.play_piece(pos)
	
	$Visual_Interface.remove_playable_tile()
	$Visual_Interface.remove_effected_tile()
	
	
	
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
	

#-------------TODO: effect managing methods

func select_effect(id):
	
	active_effect_index = id
	
	if effect_queue[active_effect_index].target_list.size() == 0:
		
		if not effect_locked[id]:
			locked_count += 1
			effect_locked[id] = true
		
		
	
	
	
	if locked_count >= effect_queue.size():
		
		end_turn()
		
	else:
		
		$Visual_Interface.build_playable_tile(effect_queue[id].target_list)
		$Visual_Interface.set_active_piece(effect_queue[id].author)
	
func rebuild_effect():
	
	var e_list = []
	
	effect_locked = []
	locked_count = 0
	for piece_active in effectors_entity:
		
		#print( piece_active)
		e_list.append($Board.build_effect_data($Board.get_piece_pos(piece_active)))
		effect_locked.append(false)
		
	effect_queue = e_list
	
	if effect_queue.size()>1:		#check if more than 1 effect to update effect button
			$Visual_Interface/Button_banner.update_effect_button(false)
	else:
		$Visual_Interface/Button_banner.update_effect_button(true)
	
func solve_effect(target):
	
	var working = effect_queue[active_effect_index]
	
	if working.type == EffectManager.TYPE.move:
		
		$Board.move_piece(working.author, target)
		await $Visual_Interface.move_piece(working.author, target)
		
	elif working.type == EffectManager.TYPE.switch:
		
		$Board.switch_piece(working.author, target)
		await $Visual_Interface.switch_piece(working.author, target)
		
	elif working.type == EffectManager.TYPE.push:
		
		$Board.push_piece(working.author, target)
		await $Visual_Interface.push_piece(working.author, target)
		
		
	$Board.rebuild_proximiy()
		
	effect_queue.remove_at(active_effect_index)
	effectors_entity.remove_at(active_effect_index)
	
	#print("DEBUG :")
	#print(effect_queue)
	#print(effectors_entity)
	
	rebuild_effect()
	
	#print(effect_queue)
	#print(effectors_entity)
	$Visual_Interface.remove_playable_tile()
	$Visual_Interface.hide_move_arrow()
	
	if effect_queue.size() > 0:
		
		
		select_effect(0)
		
	else:
		
		#state = STATE.place
		end_turn()


func end_turn():
	
	
	$Visual_Interface/Button_banner.update_effect_button(true)		#disable effect button until reactivated
	
	update_score()
	
	$Visual_Interface.reset_score()
	$Visual_Interface.build_score()
	
	new_turn()
	
	if piece_list.size() >= 1:
		draw_piece()
		show_playable(current_piece.color)
	else:
		
		end_game()
	
func end_game():
	
	$Visual_Interface/Text_Box/Text_Box_2.clear()
	$Visual_Interface/Text_Box/Text_Box_2.set_text("Game Finished")
	$Visual_Interface/Text_Box/Text_Box_2.write_all()
	
	state = STATE.finished
	
	
func write_text(text):
	
	$Visual_Interface/Text_Box/Text_Box_2.clear()
	$Visual_Interface/Text_Box/Text_Box_2.set_text(text)
	$Visual_Interface/Text_Box/Text_Box_2.write_all()
	
func close_dialog_box():
	
	pass
	
func create_popup(pos,callable):
	
	$UI/Click_Blocker.add_child(WindowManager.create_confirm_popup(pos,callable))
	
func create_dialog_popup(callable,txt,button_txt= 'ok'):
	
	var diag = WindowManager.create_dialog_popup(callable,txt,button_txt)
	diag.can_close = false
	$UI/Click_Blocker.add_child(diag)
	InputManager.connect("validate",diag.on_click)
	
func create_text_popup(txt):
	
	var ppup = load("res://Ui/Menu/popup_text.tscn")
	var ppup_i = ppup.instantiate()
	ppup_i.set_text(txt)
	InputManager.connect("validate",ppup_i.on_click)
	InputManager.connect("key_validate",ppup_i.on_click)
	popup_text_present = true
	$UI/Click_Blocker.add_child(ppup_i)
	
func close_text_popup():
	
	popup_text_present = false	
	emit_signal("text_popup_was_closed")
	
	
func update_score():
	
	Score.reset()
	$Board.calc_score()
	#Score.calc_score()
	$Visual_Interface.update_score(Score.calc_score())
	$Visual_Interface/Overlay/Color_Lines.update_tilemap($Board.content,Score.color_groups.size())
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
