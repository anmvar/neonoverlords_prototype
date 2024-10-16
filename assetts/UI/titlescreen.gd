extends CanvasLayer

var main_game_scene = preload("res://master_scene.tscn")

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_game() -> void:
	
	pass # Replace with function body.

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	get_tree().change_scene_to_file("res://master_scene.tscn")
	start_game.emit()
	pass # Replace with function body.
	
func _on_gen_timer_timeout() -> void:
	$GenMessage.hide()
	pass # Replace with function body.

func _on_exit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_popup_menu_pressed() -> void:
	$PopupMenu/OptionsMenu.visible = not $PopupMenu/OptionsMenu.visible
	pass # Replace with function body.
