extends Control


signal validated

enum STATE{clear,writing,done}
var state = STATE.clear
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	$TextureButton.connect("pressed",InputManager.transmit_text_validate)
	
	
func clear():
	
	$Label.visible_characters= 0
	state = STATE.clear
	
func write_all():
	
	$Label.visible_characters= -1
	state = STATE.done
	
func set_text(txt):
	
	$Label.text = txt


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#Workaround for clickable text_box
#func _on_gui_input(event):
#	print(event,event.type)
