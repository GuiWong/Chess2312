extends Control

var scorefile = "Scores"
var scoreline =preload("res://Ui/Menu/score_line.tscn")

var scores=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#save("GuiWong:46")

	#await get_tree().create_timer(1)
	clear_score_line()
	read_score()

func save(content):
	var file = FileAccess.open(scorefile,FileAccess.READ_WRITE)
	file.seek_end()
	
	file.store_string('\n' + content)
	file = null

func load_game():
	var file = FileAccess.open(scorefile,FileAccess.READ)
	var content = file.get_as_text()
	return content
	
func add_score_line(player,value):
	
	#print("player " + player + " scored "+ value)
	
	var line = scoreline.instantiate()
	line.player = player
	line.value = value
	$ScrollContainer/VBoxContainer.add_child(line)
	
func clear_score_line():
	
	for i in range($ScrollContainer/VBoxContainer.get_child_count(-1)):
		
		$ScrollContainer/VBoxContainer.remove_child($ScrollContainer/VBoxContainer.get_child(i+1))


func compare_score(sc1,sc2):
	
	return int(sc1[1]) > int(sc2[1])

func read_score():
	
	var scores = []
	var file = FileAccess.open(scorefile,FileAccess.READ)
	var content = file.get_as_text()
	var c1 = content.split("\n")
	
	for d in c1:
		
		var c2 = d.split(":")
		if c2.size() == 2:
			#add_score_line(c2[0],c2[1])
			scores.append(c2)
			
			
	scores.sort_custom(compare_score)
	
	for s in scores:
		
		add_score_line(s[0],s[1])
	
	#print (c1)
	
