extends Node


# Called when the node enters the scene tree for the first time.
var enemy_scene = preload("res://purple_enemy.tscn")#.instantiate()  # Path to your enemy scene
#var game_paused = false
#@onready var pause_screen: Control = $CanvasLayer/PauseScreen

func _ready():  
	print("spawn on")
	var timer = $Timer
	print("Timer node:", timer) 
	timer.stop()
	timer.start()  # Start the timer
	print("Timer started:", timer.is_stopped()) 
	#pause_screen.hide()
	
	pass
	
func _process(float) -> void:
	pass
	#toggle_pause()
	##print("Game paused state: ", game_paused)
	##print("Tree paused state before setting: ", get_tree().paused)
	#
	#if game_paused:
		#pause_screen.show()
		#get_tree().paused = true
	#else:
		#get_tree().paused = false
		#pause_screen.hide()
	#pass


#func toggle_pause():
	#if Input.is_action_just_pressed("pause_toggle"):
		#game_paused = not game_paused
		#print("pause button was pressed")
		#print("game paused is: ", game_paused, " and tree pause is:", get_tree().paused)
		#
	##if Input.is_action_just_pressed("pause_toggle") and game_paused == true:
		##game_paused = not game_paused
		##print("unpaused game")
		##print("game paused is: ", game_paused)
	#pass

func _on_timer_timeout():
	print("spawn")
	spawn_enemy()
	
	pass

func spawn_enemy():  # Instance the enemy scene
	var enemy_instance = enemy_scene.instantiate()
	
	get_parent().add_child(enemy_instance) 
	enemy_instance.position = Vector2(1000,200)
	
	
	if enemy_instance and enemy_instance.is_inside_tree() == false:
		get_parent().add_child(enemy_instance)
	
	var enemy_node_location = get_tree().get_root().get_node("PurpleMob")

	
	enemy_instance.connect("enemy_died", Callable(enemy_node_location, "_on_enemy_died"))
	
	pass
	
func _on_enemy_died(position):
	print("Enemy died at position: ", position) 
	
	pass

	
func new_game():
	$CanvasLayer.show_message("GET READY TO SHAKE")
	$StartTimer.start()
	pass

func game_over():
	$CanvasLayer.show_game_over()
	pass
	


func _on_start_timer_timeout() -> void:
	pass # Replace with function body.
	
	
