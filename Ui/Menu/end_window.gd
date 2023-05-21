extends Control

var max_score = 175
var score = 210

var done = true



# Called when the node enters the scene tree for the first time.
func _ready():
	
	$ScoreBar.max_value = max_score
	$ScoreBar.value = 0
	
	done= false
	
	$Quit.connect("pressed",SceneManager.load_main_menu)
	$Replay.connect("pressed",SceneManager.load_game_scene)
	$savescore.connect("pressed",self.save_score)
	
	$playername.placeholder_text = MySettings.player_name
	

func save_score():
	
		MySettings.player_name = get_player_name()
		MySettings.save_score(get_player_name(),score)
		$savescore.disabled = true

func get_player_name():
	
	if $playername.text == "":
		return $playername.placeholder_text
	else:
		return $playername.text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not done:
		#$ScoreBar.value = lerp($ScoreBar.value,score,0.2)
		$ScoreBar.value += 1
		$Points.text = str ($ScoreBar.value)
		
		if $ScoreBar.value >= score:
			
			done = true
			
			$ScoreBar.value = score
			$Points.text = str(score)
