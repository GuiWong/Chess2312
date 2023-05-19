extends Node2D


var tile = preload("res://tile.gd")
var piece = preload("res://piece.gd")
var playable_list = []

const dirs = [Vector2(-1,0),
				Vector2(1,0),
				Vector2(0,-1),
				Vector2(0,1),
				Vector2(-1,-1),
				Vector2(1,1),
				Vector2(1,-1),
				Vector2(-1,1),]

var content

# Called when the node enters the scene tree for the first time.
func _ready():
	var c = 0
	content = []
	for y in range(8):
		c = 1-c
		content.append([])
		for x in range(8):
			content[y].append(tile.new(c))
			
			c= 1-c
			
			

			

func get_playable_tile(c,r=false,starting = false):
	
	var t_list = []
	
	if r:
		for y in range(8):
			for x in range(8):
				var c_tile = content[y][x]
				
				if c_tile.content != null or starting:
					t_list.append(Vector2(x,y))
						
	else:
		for y in range(8):
			for x in range(8):
				var c_tile = content[y][x]
				
				if c_tile.content == null and c_tile.color == c and (starting or c_tile.in_range):
					t_list.append(Vector2(x,y))
	playable_list = t_list
	return t_list
	
func is_in_board(pos):
	
	return pos.x >= 0 and pos.x < 8 and pos.y >= 0 and pos.y < 8 
	
	
func can_play(pos):
	
	if pos in playable_list:
		
		return true
	else:
		
		return false

func get_adj_effects(pos):
	
	var t_list = []
	for d in EffectManager.adj:
		if is_in_board(pos + d):
			var processed_tile = content[pos.y+d.y][pos.x+d.x]
			if processed_tile.content != null:
				if processed_tile.content.type > 1 and processed_tile.content.type != piece_data.TYPE.KING:
					t_list.append(pos+d)
	return t_list
	
func build_effect_data(pos):
	
	var type = EffectManager.pawn_effect[content[pos.y][pos.x].content.type]
	var targets = []
	var q = []
	
	if type[0] == EffectManager.TYPE.move:
		
		for d in type[1]:
			
			var valid = false
			if is_in_board(Vector2(pos.x+d.x,pos.y+d.y)) and content[pos.y+d.y][pos.x+d.x].content == null:
				targets.append(Vector2(pos.x+d.x,pos.y+d.y))
				
	elif type[0] == EffectManager.TYPE.switch:
		
		for d in type[1]:
			if is_in_board(Vector2(pos.x+d.x,pos.y+d.y)) and content[pos.y+d.y][pos.x+d.x].content != null:
					targets.append(Vector2(pos.x+d.x,pos.y+d.y))
					
	elif type[0] == EffectManager.TYPE.push:
		
		for dir in type[1]:
			var ended = false
			var dist = 1
			while  not ended:
				
				if is_in_board(Vector2(pos.x+dir.x*dist,pos.y+dir.y*dist)):
					if content[pos.y+dir.y*dist][pos.x+dir.x*dist].content == null:
					
						ended = true
				else:
					
					dist = 0
					ended = true
					
				dist += 1
			if dist > 2:
				
				targets.append(Vector2(pos.x+dir.x,pos.y+dir.y))
				q.append(dist-1)
				
	return EffectManager.create_effect(type[0],pos,targets,q)
				
			
func play_piece(pawn,pos):
	
	content[pos.y][pos.x].content=pawn
	var mi = -1
	var ma = 1
	if pawn.type == 1:
		mi = -2
		ma= 2
	for y in range(mi,ma+1):
		for x in range(mi,ma+1):
			
			content[min(7,max(0,pos.y+y))][min(7,max(0,pos.x+x))].in_range = true
			
	var e_list = []
	
	for effected_by in get_adj_effects(pos):
		
		e_list.append(build_effect_data(effected_by))
		
	playable_list = []
		
	return e_list
	
func move_piece(o,d):
	
	content[d.y][d.x].content = content[o.y][o.x].content
	content[o.y][o.x].content =null
	#print (content[o.y][o.x] , content[d.y][d.x])
	
func switch_piece(o,d):
	
	var tmp = content[d.y][d.x].content
	content[d.y][d.x].content = content[o.y][o.x].content
	content[o.y][o.x].content =tmp
		
func push_piece(o,d):
	
	var dir = d-o
	#var done = false
	var current = content[o.y][o.x].content
	content[o.y][o.x].content = null
	var next
	var dist = 1
	while current != null:
		var tar = o + dir * dist
		next = content[tar.y][tar.x].content
		
		content[tar.y][tar.x].content = current
		current = next
		
		dist += 1
		
		
func get_piece(pos):
	
	return content[pos.y][pos.x].content
	
func get_piece_pos(p):
	
	for y in range(8):
		for x in range(8):
			if content[y][x].content == p:
				
				return Vector2(x,y)
				
func calc_pattern(pos,type):
	
	var score = 0
	var dir_mask = 0
	if type == piece_data.TYPE.HORSE:
		for d in EffectManager.dirs:
			
			if is_in_board(Vector2(pos.x+d.x, pos.y+d.y)) and content[pos.y+d.y][pos.x+d.x].content == null:
				
				score += 1
				dir_mask += EffectManager.dir_mask[EffectManager.dirs.find(d)]
				
	elif type == piece_data.TYPE.TOWER:
		
		for d in EffectManager.adj:
			
			if is_in_board(Vector2(pos.x+d.x, pos.y+d.y)) and content[pos.y+d.y][pos.x+d.x].content != null and content[pos.y+d.y][pos.x+d.x].content.type == piece_data.TYPE.PAWN:
				
				score += 2
				dir_mask += EffectManager.dir_mask[EffectManager.dirs.find(d)]
				
	elif type == piece_data.TYPE.BISHOP:
		
		for d in EffectManager.diags:
			
			if is_in_board(Vector2(pos.x+d.x, pos.y+d.y)) and content[pos.y+d.y][pos.x+d.x].content != null and content[pos.y+d.y][pos.x+d.x].content.type == piece_data.TYPE.PAWN:
				
				score += 2
				dir_mask += EffectManager.dir_mask[EffectManager.dirs.find(d)]
				
	elif type == piece_data.TYPE.KING or type == piece_data.TYPE.QUEEN:
		
		for d in EffectManager.adj:
			
			if is_in_board(Vector2(pos.x+d.x, pos.y+d.y)) and content[pos.y+d.y][pos.x+d.x].content != null and ( content[pos.y+d.y][pos.x+d.x].content.type == piece_data.TYPE.KING or content[pos.y+d.y][pos.x+d.x].content.type == piece_data.TYPE.QUEEN):
				
				score += 5
				dir_mask += EffectManager.dir_mask[EffectManager.dirs.find(d)]
				
	Score.add_pattern(pos,score,dir_mask)
	
	return score
				
func form_color_group(pos,id):
	
	var queue = [pos]
	var members = []
	
	if content[pos.y][pos.x].color_group_id != 0:
		return 0
	else:
		content[pos.y][pos.x].color_group_id = id
		
	var color = content[pos.y][pos.x].content.color
	var quantity = 1
	
	while queue.size() > 0:
		
		for d in EffectManager.adj:
			
			if is_in_board(Vector2(queue[0].x+d.x,queue[0].y+d.y)) and content[queue[0].y+d.y][queue[0].x+d.x].content != null and content[queue[0].y+d.y][queue[0].x+d.x].content.color == color and content[queue[0].y+d.y][queue[0].x+d.x].color_group_id == 0:
				
				quantity += 1
				queue.append(Vector2(queue[0].x+d.x,queue[0].y+d.y))
				content[queue[0].y+d.y][queue[0].x+d.x].color_group_id=id
		
		
		if quantity == 1:
			content[queue[0].y][queue[0].x].color_group_id = 0
			quantity = 0
		
			
		members.append(queue[0])
		queue.remove_at(0)
		
	#Score.add_color_group(id,quantity)
	
	if quantity > 0:
		Score.add_color_group(id,quantity,members)
	return quantity
		
		
func calc_score():
	
	for y in range(8):
		for x in range(8):
			
			content[y][x].color_group_id = 0
			
	var c_counter = 1
	for y in range(8):
		for x in range(8):
			
			if content[y][x].content != null:
				
				var q = form_color_group(Vector2(x,y),c_counter)
				if q > 0:
					c_counter +=1
					
				if content[y][x].content.type > 0:
					
					var s = calc_pattern(Vector2(x,y),content[y][x].content.type)
		
func _process(delta):
	pass
