extends Control

var game_paused = false

func _ready():   
	self.hide()
pass
	
func _process(float) -> void:
	toggle_pause()
	if game_paused:
		self.show()
		get_tree().paused = true
	else:
		get_tree().paused = false
		self.hide()
	pass


func toggle_pause():
	if Input.is_action_just_pressed("pause_toggle"):
		game_paused = not game_paused
		print("pause button was pressed")
		print("game paused is: ", game_paused, " and tree pause is:", get_tree().paused)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass #
	
	
func _on_main_title_button_pressed() -> void:
	get_tree().change_scene_to_file("res://titlescreen.tscn")
	pass # Replace with function body.
