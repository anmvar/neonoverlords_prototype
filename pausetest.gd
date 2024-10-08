extends Node2D

var game_paused = false

func _ready():
	print("Press 'Esc' to toggle pause")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_toggle"):
		game_paused = not game_paused
		print("Game paused: ", game_paused)
		print("Tree paused: ", get_tree().paused)
