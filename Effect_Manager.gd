extends Node

enum DIR{left,right,up,down,up_left,down_right,up_right,down_left}
enum TYPE{move,switch,push}
const dirs = [Vector2(-1,0),
				Vector2(1,0),
				Vector2(0,-1),
				Vector2(0,1),
				Vector2(-1,-1),
				Vector2(1,1),
				Vector2(1,-1),
				Vector2(-1,1),]
				
const dir_mask= [1,2,4,8,16,32,64,128]


				
const pawn_effect = [null,null,
					[TYPE.switch,dirs],
					[TYPE.push,adj],
					[TYPE.move,diags],
					[TYPE.move,dirs]]
				
				#WARNING : ORDER SWITCH FROM:
				
#const diags = [dirs  [DIR.up_left],dirs[DIR.up_right],dirs[DIR.down_left],dirs[DIR.down_right]]

				# TO
const diags = [dirs[DIR.up_left],dirs[DIR.down_right],dirs[DIR.up_right],dirs[DIR.down_left]]				
				
const adj =[dirs[DIR.left],dirs[DIR.right],dirs[DIR.up],dirs[DIR.down]]

const effect_b = preload("res://Effect.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func create_effect(type,author,targets,quantity=1):
	
	return effect_b.new(type,author,targets,quantity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
