extends Node2D


var blob = preload("res://Ui/color_blob.tscn")
func _ready():
	pass # Replace with function body.


func update_tilemap(data,group_quantity):
	
	var groups = [null]
	var anchor = [null]
	for i in range(group_quantity):
		groups.append([])
		anchor.append(null)
		for yy in range(8):
			groups[i+1].append([])
		
	$TileMap.clear()
	
	for c in $Blobs.get_children():
		
		c.queue_free()
	
	for y in range(8):
		#groups.append([])
		for x in range(8):
			
			if data[y][x].color_group_id != 0:
				
				groups[data[y][x].color_group_id][y].append(Vector2(x,y))
				#$TileMap.set_cells_terrain_path(Vector2(x,y),groups[data[y][x].color_group_id],0,0)
				
				if data[y][x].content.type == 0 and anchor[data[y][x].color_group_id] == null:
				
					anchor[data[y][x].color_group_id] = Vector2(x,y)
			else:
				
				pass
				
	for i in range(group_quantity):
		
		for line in range(8):
			$TileMap.set_cells_terrain_path(0,groups[i+1][line],0,0)
			
	groups = [null]
	for i in range(group_quantity):
		groups.append([])
		for yy in range(8):
			groups[i+1].append([])
	
	
	for x in range(8):
		#groups.append([])
		for y in range(8):
			
			if data[y][x].color_group_id != 0:
				
				groups[data[y][x].color_group_id][x].append(Vector2(x,y))
				
	for i in range(group_quantity):
		
		for line in range(8):
			$TileMap.set_cells_terrain_path(0,groups[i+1][line],0,0)
		
		#TODO: Line/Column based connection
		#					A
		#					|
		#			I was doing that
		
		#			kinda done, a bit bugged...
		#
		#--------------------------------------
		
	for g in range(anchor.size()-1):
		
		var blob_i = blob.instantiate()
		if anchor[g+1] != null :
	
			blob_i.position = anchor[g+1] * 24 #+ Vector2(8,8)
			
		else:
			
			#todo: grab a random piece from group
			var first_pos=null
			var column = 0
			
			#var members = []
			#for l in range(8):
				
			#	members.append_array(groups[g+1][l])
				
			#first_pos = members[0]
			while first_pos == null:
				
				if groups[g+1][column].size() > 0:
					
					first_pos = groups[g+1][column][0]
				column += 1
				
				if column == 8 and first_pos == null:
					first_pos = Vector2(0,0)
				
			blob_i.position = first_pos * 24
			
		blob_i.get_child(1).get_child(1).text = str(Score.group_point[Score.color_groups[g][1]])
		
		$Blobs.add_child(blob_i)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
