extends Node


signal kill_count_updated(count)

var kill_count = 0

func _ready():
	kill_count = 0
	pass
	

func _process(delta):
	
	pass
	

func reset_kill_count():
	var current_scene_path = get_tree().current_scene.get_path()
	if str(current_scene_path) != "res://master_scene.tscn" and str(current_scene_path) != "res://titlescreen.tscn":
		kill_count = 0
		print("Kill count reset to: ", kill_count)
		emit_signal("kill_count_updated", kill_count)
	pass

# Method to increment the kill count
func increase_kill_count():
	kill_count += 1
	print("Total kill count: ", kill_count)
	emit_signal("kill_count_updated", kill_count) 
