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


var line_ui_1 = "This overlay shows how many points are scored by the proximity bonus of pieces. The number inside the circle tells you the points this piece is scoring. The lines show what is making this piece earn points.
In this case, the TOWER is scoring 2 points thanks to the adjacent pawn."


var TUTO_HINTS = "You can check bonus and effect \n of a piece by clicking on it's \n image in this window."

var TUTO_PEDESTAL ="Each turn, a piece \n is displayed here \n \n press [ENTER] to continue" 

var POPUP_COLOR_UI ="This overlay shows the points scored by group af same-color pieces. \n each group has one circle showing the points for the whole group."
var POPUP_COLOR_SCALING1="The scoring of color-group is hard to explain. It is probably different from original chess, as very few documents about that aspect have been found.

the basic rule is: 
the more piece
the more points"

var POPUP_COLOR_SCALING2 = "To explain a bit more how it works,
each additional piece add more point.

the 1st 2nd and 3rd add 1 point
4th and 5th add 2 point
6th and 7th add 3 points
...
So a 6 pieces group will score:
1+1+1+2+2+3 = 10 points"

var skip_rule =[
	
			[1,0,0,0],
			[0,0,0,2],
			[2,0,0,0],
			[0,0,0,2],
			[0,0,0,0],
			[0,0,0,0],
			[0,0,0,0],
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
	
			[TUTO_PEDESTAL,
			"TUTO_PLACEMENT",
			null,
			null],
			
			[null,
			"TUTO_RANGE",
			null,
			"TUTO_OVERLAY"],
			
			[TUTO_HINTS,#"TUTO_TOWER_BONUS",
			"TUTO_HORSE_BONUS",
			null,
			null],
			
			[null,
			"TUTO_EFFECT_INTRO",
			"TUTO_HORSE_EFFECT",
			"TUTO_COLOR_UI"],
			
			[null,#TUTO_COLOR_BONUS_INTRO",
			"TUTO_BISHOP_BONUS",
			"TUTO_MANDATORY_EFFECT",
			null],
			
			[null,
			"TUTO_FUN_FACT1",
			"TUTO_BISHOP_EFFECT",
			null#"TUTO_COLOR_GROUP_SCALING"
			],
			
			[null,#"TUTO_COLOR_GROUP_SCALING2",
			"TUTO_QUEEN_BONUS",
			"Again, move the dog.",
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
