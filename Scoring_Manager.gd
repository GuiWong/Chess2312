extends Node


var color_groups = []
var patterns = []
var score = 0

var group_point=[0,0,2,4,7,11,16,21,26,31,36,41,46,51,56,61,66]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset():
	
	color_groups = []
	patterns = []
	score = 0

func add_color_group(id,value,content):
	
	color_groups.append([id,value,content])
	
func add_pattern(pos,value,dir_mask):
	
	patterns.append([pos,value,dir_mask])
	
func calc_score():
	
	var v = 0
	
	for c in color_groups:
		v+=group_point[c[1]]
		#print ("color group " +str(c[0]) + " scoring " + str(c[1]) + " points")
	for p in patterns:
		v+= p[1]
		#print("pattern at " + str(p[0].x) + ":" +  str(p[0].y) + " scoring " + str(p[1]) + " points")
	score = v
	return v
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
