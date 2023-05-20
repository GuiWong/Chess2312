extends Node2D


var just_play = "play on the marked spot"

var temp_line = "Some people say that knowledge 
from the old games have been lost.
Let's show them how wrong they are.
I'll teach you how to play chess. \n \n \n press [ENTER] or click anywhere to close this window"

var line_no = "Chess was known worldwide since the 3rd Crusade in 1872. I'll teach you using a method most historians believe was used by schools before the 2129 war.

I'll Use the smaller text box for instructions. It should be quick. "

var line_2 = "Chess is a singleplayer game, where you place pieces on a 8x8 board.

All 32 pieces have to be placed to finish the game. 

Each turn, the player draws a random piece and then place it on the board."


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
