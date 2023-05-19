extends Node2D


signal new_turn_done
signal draw_piece_done
signal show_playable_done
signal validate_done
signal place_piece_done
signal select_effect_done
signal solve_effect_done
signal end_turn_done


var piece = preload("res://piece.tscn")
var active_piece

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new_game():
	
	pass
	
func new_turn():
	
	pass
	
func draw_piece(color,type):
	
	var p = piece.instantiate()
	p.color = color
	p.type = type
	
	active_piece = p
	$Hand.add_child(p)
	
func update_turn_counter(t):
	
	$Control/HBoxContainer/Label2.text = str(t)
	
func update_score(value):
	
	$Control/Score/Label6.text = str(value)
	
func move_selector(pos):
	
	$Board/Selector.position = pos * 24
	
func build_playable_tile(listed):
	
	$Board.build_playable_tile(listed)
	
func remove_playable_tile():
	
	$Board.remove_playable_tile()
	
func build_effected_tile(listed):
	
	$Board.build_effected_tile(listed)
	
func remove_effected_tile():
	
	$Board.remove_effected_tile()
	
	
func show_move_arrow(pos,dest):
	
	$Board/Targets/Move_Shower.visible = true
	var angle = (dest-pos).angle_to(Vector2(0,-1))
	#print (angle)
	$Board/Targets/Move_Shower.position = pos * 24
	$Board/Targets/Move_Shower.rotation = - angle
	
func hide_move_arrow():
	
	$Board/Targets/Move_Shower.visible = false
	
	
func play_piece(pos):
	
	active_piece.reparent($Board/Pieces)
	active_piece.position = pos *24
	
func remove_piece(pos):

	var removed = get_piece_form_pos(pos)
	removed.queue_free()
	
func move_piece(o,d):
	
	var auth = get_piece_form_pos(o)
	var dir = (d-o).normalized()
	
	#print(auth.position.distance_to(d *24))
	while auth.position.distance_to(d *24) > 4:
		
		auth.position = auth.position + dir * 4.0#lerp(auth.position,d *24,0.2)
		await(get_tree().create_timer(0.03).timeout)
		#print(auth.position.distance_to(d *24))
		
	auth.position = d *24
	
	reset_active_piece()
	
	
func switch_piece(o,d):
	
	var des = get_piece_form_pos(d)
	var ori = get_piece_form_pos(o)
	
	var dir = (d-o) * 24
	
	var center_global = o * 24 + dir / 2.0
	
	#var angle_start = Vector2(0,-1).angle_to(o * 24 - center_global)
	var angle_fin = PI/2 #+ angle_start
	#var angled_dir = dir.rotated(0.25)
	
	var angle_delta = 0.0
	
	#print(angle_fin)
	
	while angle_delta <= PI:#-dir.angle_to(ori.position - center_global ) <= angle_fin :
	
		ori.position = center_global - (dir/2.0).rotated(angle_delta)
		des.position = center_global + (dir/2.0).rotated(angle_delta)
		angle_delta += 0.25
		#print (Vector2(0,-1).angle_to(ori.position - center_global ))
		await(get_tree().create_timer(0.03).timeout)
	
	des.position = o * 24
	ori.position = d * 24
	
	reset_active_piece()
	
func push_piece(o,d):
	
	var dir = d-o
	var queue = []
	var targets = []
	#var done = false
	#queue.append( get_piece_form_pos(o))
	var next = get_piece_form_pos(o)
	var dist = 1
	
	reset_active_piece()
	
	while next != null:
		
		queue.append(next)
		var tar = o + dir * dist
		targets.append(tar)
		next = get_piece_form_pos(tar)
		
		
		dist += 1
		
	var start_pos =[]
	for j in queue:
		
		start_pos.append(j.position)
		
	while queue[0].position.distance_to(targets[0] * 24) >= 4:
		
		for i in range(queue.size()):
			
			queue[i].position = lerp(queue[i].position,targets[i] * 24,0.2 + 0.1 * i)#queue[i].position + dir.normalized() * (3 + i)
	
		await(get_tree().create_timer(0.03).timeout)
		
	print ("loop finished")
		
	for j in range(queue.size()):
		
		queue[j].position =targets[j] * 24
		
	#reset_active_piece()
	
func push_piece_old(o,d):
	
	var dir = d-o
	#var done = false
	var current = get_piece_form_pos(o)
	var next
	var dist = 1
	while current != null:
		var tar = o + dir * dist
		next = get_piece_form_pos(tar)
		
		current.position = tar * 24
		current = next
		
		dist += 1
		
	reset_active_piece()	
	
func get_piece_form_pos(pos):
	
	for p in $Board/Pieces.get_children():
		
		if p.position == pos * 24:
			
			return  p
			
	return null
			
func set_active_piece(pos):
	
	for p in $Board/Pieces.get_children():
		
		if p.position == pos * 24:
			
			active_piece = p
			active_piece.toggle_active()
			
func reset_active_piece():
	
	active_piece.toggle_active()
	active_piece = null
	
	
	#TODO:  Setup score_overlay scene
func set_overlays_visible(state):
	
	$Overlay.visible = state	

func set_overlay_layer_visible(id,state):
	
	if id == 1:
		
		$Overlay/Score_UI.visible = state
		
	elif id == 2:
		
		$Overlay/Color_Lines.visible = state
	
func show_score():
	$Overlay/Score_UI.visible = true
func hide_score():
	$Overlay/Score_UI.visible = false
func reset_score():
	for i in $Overlay/Score_UI.get_children():
		
		$Overlay/Score_UI.remove_child(i)
		
	#for j in $Color_Score/Control/Color_Score.get_children():
		
	#	$Color_Score/Control/Color_Score.remove_child(j)
		
func show_color_groups():
	$Overlay/Color_Lines.visible = true
	
func hide_color_groups():
	$Overlay/Color_Lines.visible = false
		
func build_score():
	var blob = load("res://Ui/blob_full.tscn")
	for p in Score.patterns:
		var b_i = blob.instantiate()
		b_i.position = p[0] * 24
		b_i.get_child(0).get_child(1).text = str(p[1])
		b_i.build(p[2])
		$Overlay/Score_UI.add_child(b_i)
		
	var line = load("res://Ui/color_score_line.tscn")
	
	for c in Score.color_groups:
		
		var c_i = line.instantiate()
		c_i.get_child(0).text = str( c[1])
		c_i.get_child(2).text = str(Score.group_point[c[1]])
		
		$Color_Score/Control/Color_Score.add_child(c_i)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
