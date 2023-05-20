extends Control

var done = false
var step = 0.0
var speed = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#speed = MySettings.text_speed
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not done:
		
		step += speed
		#print(step)
		$Control/Label.visible_characters = floor(step)
		
		if $Control/Label.visible_characters >= $Control/Label.text.length():
			
			done = true
			
		#if $Control/Label.visible_characters == -1:
			
		#	print("huh")
		#	done = true
			
func set_text(txt):
	
	$Control/Label.text = txt

func start():
	
	done = false
	$Control/Label.visible_characters = 0
	step = 0.0

func skip():
	
	done = true
	$Control/Label.visible_characters = -1
	step = 0.0
	
func on_click():
	
	if done:
		InputManager.emit_signal("text_popup_confirm")
		
		queue_free()	#todo: animate closing
	else:
		skip()
