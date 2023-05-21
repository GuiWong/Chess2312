extends Node


var ui_scale = 1.0
var text_speed = 1.0
var max_scale_factor

var player_name = "Player"
var score_file = "Scores"



# Called when the node enters the scene tree for the first time.
func _ready():
	
	var screen_size = 0
	
	var size = DisplayServer.screen_get_size()
	
	var max_x = size.x / 480
	var max_y = size.y / 480
	
	max_scale_factor = max(min(max_y,max_x),1)
	
	
func save_score(player,value):
	
	var file = FileAccess.open(score_file,FileAccess.READ_WRITE)
	file.seek_end()
	
	file.store_string('\n' + player + ":" + str(value))
	file = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
