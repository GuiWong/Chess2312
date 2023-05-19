extends Node2D


var size = 24
var piece = preload("res://piece.tscn")

var currently_playing = 0
var piece_list = []
var current_piece
var current_turn


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	new_game()
	
func new_game():
	
	var t_list = []
	var c = 0
	while c <= 1:
		for i in range(8):
			t_list.append($Board.piece.new(c,0))
		for j in range(4):
			t_list.append($Board.piece.new(c,j/2+1))
		for k in range(2):
			t_list.append($Board.piece.new(c,5))
		t_list.append($Board.piece.new(c,3))
		t_list.append($Board.piece.new(c,4))
		c +=1
		
	piece_list = t_list
	
	current_turn=-1
	
func draw_piece():
	
	current_turn += 1
	var i = randi_range(0,piece_list.size()-1)
	var c = piece.instantiate()
	c.color= piece_list[i].color
	c.type = piece_list[i].type
	piece_list.remove_at(i)
	$Piece_Bag.add_child(c)
	current_piece = c
	print (c,$Piece_Bag.get_child(0))
# Called every frame. 'delta' is the elapsed time since the previous frame.

func show_playable_tiles():
	
	var first = false
	var replace = false
	if current_turn == 0:
		first = true
	var listed = $Board.get_playable_tile(current_piece.color,replace,first)
	$Visual_board.build_playable_tile(listed)
	
func add_piece_test(pos,color,type):
	
	#$Board.content[pos.y][pos.x].content = $Board.piece.new(color,type)
	$Board.play_piece(current_piece,pos)
	#var piece_i = piece.instantiate()
	#piece_i.color = color
	#piece_i.type = type
	var playing = $Piece_Bag.get_child(0)
	
	playing.reparent($Visual_board/Tiles)
	playing.position = pos * size #+ Vector2(12,12)
	#piece_i.position = pos * size + Vector2(12,12)
		
	#add_child(piece_i)
	
	$Visual_board.remove_playable_tile()


func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_pos = mouse_pos - position
	var mouse_tile_pos = floor(mouse_pos / size)
	
	$Selection_Cross.position = mouse_tile_pos * size + Vector2(12,12)
	
	
	if Input.is_action_just_pressed("ui_right"):
		#currently_playing = (currently_playing + 1 ) % 6
		draw_piece()
		show_playable_tiles()
	
	
	if Input.is_action_just_pressed("click"):
	
		#print(mouse_pos)
		add_piece_test(mouse_tile_pos,current_piece.color,current_piece.type)
	
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		
	#	add_piece_test(mouse_tile_pos,current_piece.color,current_piece.type)
