extends Node

var window_scene = preload("res://Ui/Menu/window.tscn")
var popup_scene = preload("res://Ui/Menu/popup_confirm.tscn")
var dialog_popup_scene = preload("res://Ui/Menu/popup_dialog.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func create_confirm_popup(pos,callable):
	
	var p_pup =popup_scene.instantiate()
	
	p_pup.setup(callable)
	p_pup.position = pos
	
	return p_pup
	
func create_dialog_popup(callable,txt,button_txt= 'ok'):

	var p_pup = dialog_popup_scene.instantiate()
	p_pup.setup(callable,txt,button_txt)
	
	return p_pup
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
