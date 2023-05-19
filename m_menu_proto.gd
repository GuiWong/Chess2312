extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_game():
	
	SceneManager.load_game_scene()
	
func start_tutorial():
	
	SceneManager.load_tutorial_scene()
