extends Node

var game_scene = preload("res://game.tscn")
var tutorial_scene = preload("res://tutorial.tscn")
#var main_menu_scene = preload("res://Ui/Menu/main_menu.tscn")
var main_menu_scene = preload("res://Ui/Menu/main_menu_2.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_game_scene():
	
	get_tree().change_scene_to_packed(game_scene)
	
func load_tutorial_scene():
	
	get_tree().change_scene_to_packed(tutorial_scene)
	
func load_main_menu():
	
	get_tree().change_scene_to_packed(main_menu_scene)
