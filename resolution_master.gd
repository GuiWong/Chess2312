extends Node2D

var res_x
var res_y
var strech = 3

var width = 480
var height = 270

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.connect("size_changed",self.test_resize)
	switch_strech()
	
func switch_strech():
	
	ProjectSettings.set_restart_if_changed('display/window/stretch/scale',true)
	ProjectSettings.set_setting('display/window/stretch/scale',1)
	
	#ProjectSettings.save()

func test_resize():
	
	print("window changed" + str(get_viewport().size))
	res_x = get_viewport().size.x
	res_y = get_viewport().size.y
	
	get_child(0).position = Vector2((res_x - width*strech)/ (2 * strech) , (res_y - height*strech)/(2 * strech) )
	#get_child(0).position = Vector2(0,0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
