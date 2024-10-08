extends CanvasLayer

var main_game_scene = preload("res://master_scene.tscn")

signal start_game

func show_message(text):
	$GenMessage.text = text
	$GenMessage.show()
	$GenTimer.start()
	

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $GenTimer.timeout

	$GenMessage.text = "DENUEVOAGAINDENUEVO"
	$Message.hide()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
