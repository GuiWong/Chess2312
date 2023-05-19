extends Node2D


var just_play = "play on the marked spot"


var skip_rule =[
	
			[1,0,0,0],
			[0,0,0,2],
			[1,0,0,0],
			[0,0,0,2],
			[1,0,0,0],
			[0,0,0,1],
			[1,0,0,0],
			[0,0,0,0],
			[0,0,0,0],
			[0,0,1,0]
]

var pos_limits = [
	
					[Vector2(4,3),null],
					[Vector2(5,3),null],
					[Vector2(5,2),null],
					[Vector2(6,2),Vector2(4,2)],
					[Vector2(5,2),Vector2(3,3)],
					[Vector2(4,2),Vector2(5,3)],
					[Vector2(3,2),Vector2(4,4)],
					[Vector2(5,4),null],	#null : free placement
					[Vector2(2,2),Vector2(4,2)],
					[null,null] ,#free placement
					
					[null,null] # for not crashing
]

var lines = [
	
			["TUTO_INTRO",
			"TUTO_PLACEMENT",
			null,
			null],
			
			[null,
			"TUTO_RANGE",
			null,
			"TUTO_OVERLAY"],
			
			["TUTO_TOWER_BONUS",
			"TUTO_HORSE_BONUS",
			null,
			null],
			
			[null,
			"TUTO_EFFECT_INTRO",
			"TUTO_HORSE_EFFECT",
			"TUTO_COLOR_UI"],
			
			["TUTO_COLOR_BONUS_INTRO",
			"TUTO_BISHOP_BONUS",
			"TUTO_MANDATORY_EFFECT",
			null],
			
			[null,
			"TUTO_FUN_FACT1",
			"TUTO_BISHOP_EFFECT",
			"TUTO_COLOR_GROUP_SCALING"
			],
			
			["TUTO_COLOR_GROUP_SCALING2",
			"TUTO_QUEEN_BONUS",
			null,
			null],
			
			[null,
			"TUTO_FUN_FACT2",
			"TUTO_EFFECT_ORDER",
			null],
			
			[null,
			"TUTO_FUN_FACT3",
			"TUTO_QUEEN_EFFECT",
			null],
			
			[null,
			"TUTO_KING_EFFECT",
			"TUTO_KING_BONUS",
			null]
	
]




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
