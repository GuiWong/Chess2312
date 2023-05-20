extends Control

var done = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not done:
		$Control/Label.visible_characters += 1
		
		if $Control/Label.visible_characters >= $Control/Label.text.length():
			
			done = true
			
		if $Control/Label.visible_characters == 0:
			
			print("huh")
			done = true
			
func set_text(txt):
	
	$Control/Label.text = txt

func start():
	
	done = false
	$Control/Label.visible_characters = 0

func skip():
	
	done = true
	$Control/Label.visible_characters = -1
	
func on_click():
	
	if done:
		InputManager.emit_signal("text_popup_confirm")
		
		queue_free()	#todo: animate closing
	else:
		skip()
