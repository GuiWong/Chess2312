extends Node2D


var selected = preload("res://selected_tile.tscn")
func _ready():
	
	pass # Replace with function body.
	
	build()
	
func build():

	var tile = load("res://spot.tscn")
	var tile_i
	var c = 0
	
	for y in range(8):
		
		c = 1-c
		
		for x in range(8):
			tile_i = tile.instantiate()
			
			tile_i.position = Vector2(x*24,y*24)
			
			tile_i.get_child(0).frame = c
			
			c = 1-c
			
			
			$Tiles.add_child(tile_i)
			
			

func build_playable_tile(posis):
	for p in posis:
		var bo = selected.instantiate()
		bo.color=Color(0,1,0,1)
		bo.position=Vector2(p.x*24,p.y*24)#p*24
		$Ui.add_child(bo)
		
		
func remove_playable_tile():
	for c in $Ui.get_children():
		c.queue_free()
		
func build_effected_tile(posis):
	for p in posis:
		var bo = selected.instantiate()
		bo.color=Color(0,0,1,1)
		bo.position=Vector2(p.x*24,p.y*24)#p*24
		$Ui2.add_child(bo)
		
func remove_effected_tile():
	
	for c in $Ui2.get_children():
		c.queue_free()
		
	
func _process(delta):
	pass
