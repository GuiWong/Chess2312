extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Center/Window/Button_Menu_proto/Button.connect("pressed",SceneManager.load_game_scene)
	$Center/Window/Button_Menu_proto/Button2.connect("pressed",SceneManager.load_tutorial_scene)
	$Center/Window/Button_Menu_proto/Button3.connect("pressed",get_tree().quit)
	
	$Resolution_Placeholder/Res1.connect("pressed",set_resolution_1)
	$Resolution_Placeholder/Res2.connect("pressed",set_resolution_2)
	$Resolution_Placeholder/Res3.connect("pressed",set_resolution_3)
	$Resolution_Placeholder/Res4.connect("pressed",set_lang_fr)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_resolution_1():
	
	ProjectSettings.set_setting("display/window/stretch/scale",1)
	get_tree().root.content_scale_factor = 1
	
func set_resolution_2():
	
	ProjectSettings.set_setting("display/window/stretch/scale",2)
	
	get_tree().root.content_scale_factor = 2
	#get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,  SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1280,720),2)
	
func set_resolution_3():
	
	get_tree().root.content_scale_factor = 3
	ProjectSettings.set_setting("display/window/stretch/scale",3)
	
func set_lang_fr():

	TranslationServer.set_locale("en")
	
