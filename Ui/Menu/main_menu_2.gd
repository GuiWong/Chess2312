extends Node2D


var option_scene =preload("res://Ui/Menu/option_window.tscn")
var credit_scene =preload("res://Ui/Menu/credit_window_2.tscn")
#var credit_scene =preload("res://Ui/Menu/credit_window.tscn")
var score_scene = preload("res://Ui/Menu/score_window.tscn")

var window_open = 0	#1:setting 2:credit 3:score
	
var waiting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Window_pos/Window.setup_start_closed(Vector2(347,262))
	#badbadbad, but neeed fast
	$Window_pos/Window/Close_button/TextureButton.connect("pressed",$Window_pos/Window.close_anim)	
	
	$Window_pos/Window.connect("close_done",on_close_window_done)
	$Window_pos/Window.connect("open_done",on_open_window_done)
	$Buttons/Credits.connect("pressed",on_credit_pressed)
	$Buttons/Settings.connect("pressed",on_setting_pressed)
	$Buttons/High_Score.connect("pressed",on_score_pressed)
	
	#$Window_pos/Window.close_anim()
	
	$Buttons/New_Game.connect("pressed",SceneManager.load_game_scene)
	$Buttons/Tutorial.connect("pressed",SceneManager.load_tutorial_scene)
	$Buttons/QuitButton.connect("pressed",on_quit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_credit_pressed():
	
	on_window_button_pressed(2)
	
func on_setting_pressed():
	
	on_window_button_pressed(1)
	
func on_score_pressed():
	
	on_window_button_pressed(3)
	
func on_window_button_pressed(id):
	
	if not waiting:
	
		waiting = true
		if window_open == id:
		
			window_open = 0
			ask_window_close()
			
			await $Window_pos/Window.close_done
			
			waiting = false
		
		
		else:
		
		
			if window_open != 0:
			
				ask_window_close()
			
				await $Window_pos/Window.close_done
				
				waiting = false

		
			open_window(id)
			waiting =false

func ask_window_close():
	
	$Window_pos/Window.close_anim()
	
func on_close_window_done():
	
	#$Window_pos/Window.visible = false
	if $Window_pos/Window.get_child_count() > 3:
		$Window_pos/Window.get_child(3).queue_free()
		
	if window_open != 0:
		
		window_open = 0
	
func on_open_window_done():
	
	$Window_pos/Window.get_child(0).visible = true
	
func open_window(id):
	
	if id == 1:
		
		open_settings()
	
	if id == 2:
		
		open_credits()
		
	if id == 3:
		
		open_score()
	
func open_credits():
	
	var credits = credit_scene.instantiate()
	
	#credits.visible =false
	$Window_pos/Window.add_child(credits)
	
	window_open = 2
	$Window_pos/Window.visible = true
	$Window_pos/Window.open_anim()
	
func open_settings():
	
	var settings = option_scene.instantiate()
	
	#credits.visible =false
	$Window_pos/Window.add_child(settings)
	
	window_open = 1
	$Window_pos/Window.visible = true
	$Window_pos/Window.open_anim()
	
func open_score():
	
	

	var score = score_scene.instantiate()
	
	#credits.visible =false
	$Window_pos/Window.add_child(score)
	
	window_open = 3
	$Window_pos/Window.visible = true
	$Window_pos/Window.open_anim()
	
func quit_deny():
	
	$Click_Blocker.visible = false
	$Click_Blocker.remove_child($Click_Blocker.get_child(0))
	
func on_quit():
	
	var p_pup= WindowManager.create_confirm_popup(Vector2(0,0),quit_confirm)
	$Click_Blocker.add_child(p_pup)
	p_pup.get_child(0).connect("close_done",quit_deny)
	$Click_Blocker.visible = true
	
func quit_confirm():
	
	get_tree().quit()
