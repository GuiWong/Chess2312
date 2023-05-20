extends HBoxContainer

@export var id = 0

@export var no_text = false

var names = ["PAWN","TOWER","BISHOP","QUEEN","KING","DOG"]

# Called when the node enters the scene tree for the first time.
func _ready():


	update_visuals()
	
func update_visuals():
	
	if id <6:
		$Label.text = names[id]
		
		$TextureRect.texture.region.position.x= id * 16
		$TextureRect.visible=true
	else:
		$Label.text = "empty tile"
		$TextureRect.visible=false
		
	if no_text:
	
		$TextureRect.visible=false
		
func set_text(id):
	
	self.id = id
	update_visuals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
