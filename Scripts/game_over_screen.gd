extends CanvasLayer
var main_game_scene = preload("res://master_scene.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Current scene:", get_tree().current_scene)
	print("Script attached:", get_tree().current_scene.get_script())
	await get_tree().create_timer(1.0).timeout 
	get_tree().paused = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://master_scene.tscn")
	pass # Replace with function body.


func _on_quit_to_desktop_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_main_title_button_pressed() -> void:
	get_tree().change_scene_to_file("res://titlescreen.tscn")
	pass # Replace with function body.
