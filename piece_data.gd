class_name piece_data

enum COLOR{WHITE,BLACK}
enum TYPE{PAWN,TOWER,BISHOP,QUEEN,KING,HORSE}

var color
var type


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _init(n_color,n_type):
	
	color = n_color
	type = n_type
	
func _process(delta):
	pass
