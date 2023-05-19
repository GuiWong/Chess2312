extends Control

@export var target_size = Vector2(70,70)
var min_size = Vector2(70,70)
# Called when the node enters the scene tree for the first time.

signal close_done
signal open_done

var start_opened = true

func _ready():
	
	if start_opened:
		target_size = Vector2(size.x,size.y)


func setup_start_closed(size_final):
	
	target_size = size_final
	modulate = Color(1,1,1,0)
	size = min_size
	start_opened = false

func close_anim():
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self,"size",Vector2(min_size.x,min_size.y),0.2)
	#tween.tween_property(self,"size",Vector2(min_size.x,min_size.y),0.2)
	tween.tween_property(self,"modulate",Color(1,1,1,0),0.4)
	
	await get_tree().create_timer(0.4).timeout
	emit_signal("close_done")
	
func open_anim():
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self,"size",Vector2(target_size.x,target_size.y),0.2)
	#tween.tween_property(self,"size",Vector2(min_size.x,min_size.y),0.2)
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.4)
	
	await get_tree().create_timer(0.4).timeout
	emit_signal("open_done")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
