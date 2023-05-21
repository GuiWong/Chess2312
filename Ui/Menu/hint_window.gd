extends Node2D

var was_up

var point_text = [null,2,2,5,5,1]
var bonus_type = [null,1,1,2,2,0]
var proxy_type = [null,0,1,0,0,2]

var proxy_text = ["adjacent","diagonal","adjacent"]
var proxy_frame = [3,2,1]

var effect_list = ["none","has a greater range","swap with a neighbor","push a line","replace a piece on placement","move to an empty tile"]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	for b in $Control.get_children():
		
		b.connect("selected",on_onglet_selected)
		
	on_onglet_selected(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_bonus_piece(b_t):
	
	if b_t == 0:
		return 8
	if b_t == 1:
		return 0
	if b_t == 2:
		return 3
func on_onglet_selected(id):
	
	#print("selected " + str(id) + " help menu")
	
	$Bonus_type2.visible= false
	$Selected_Name.set_text(id)
	$Selected_Name.position = $Control.get_child(id).position + Vector2(16,16)
	
	if was_up:
		
		$Bonus_type.position += Vector2(0,8)
		was_up = false
		
	if id == 0:
		
		$Bonus_type.visible= false
		$Proxi_Image.visible = false
		
		$Point_Label.visible = false
		$Point_text.visible = false
		
	else:
		
		$Bonus_type.visible= true
		$Proxi_Image.visible = true
		$Point_Label.visible = true
		$Point_text.visible = true
		
		if id < 6 :
			
			$Point_Label.text = str(point_text[id])
			$Bonus_type.set_text(get_bonus_piece(bonus_type[id]))
			
			$Proxi_Image.frame = proxy_frame[proxy_type[id]]
			$Proxi_Image/Proxi_Label.text = proxy_text[proxy_type[id]]
			
			if id == 3 or id == 4:
				
				$Bonus_type.position += Vector2(0,-8)
				$Bonus_type2.visible = true
				was_up = true
			
	$Effect_Label.text = effect_list[id]
	

			
