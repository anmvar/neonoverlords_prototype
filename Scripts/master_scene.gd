extends Node



var enemy_scene = preload("res://purple_enemy.tscn")#.instantiate()  # Path to your enemy scene
@onready var kill_count_label: Label = $CanvasLayer/Control/KillCountLabel
@onready var health_count_label: Label = $CanvasLayer/Control/HealthCountLabel  # Reference to the health label


func _ready():  
	
	print("spawn on")
	var timer = $Timer
	print("Timer node:", timer) 
	timer.stop()
	timer.start()  
	print("Timer started:", timer.is_stopped()) 
	
	#update enemy kill count
	enemy_manager.connect("kill_count_updated", Callable(self, "_on_kill_count_updated"))
	enemy_manager.kill_count = 0
	
	#show health count on the UI
	health_count_label.text = "Health Left: " + str($Player.player_health)
	
	$Player/Camera2D/MusicPlayer.play()
	pass
	
func _process(float) -> void:
	if enemy_manager.kill_count >= 2:
		get_tree().paused = true
		await get_tree().create_timer(1.0).timeout 
		var win_transition = preload("res://Scenes/game_won_screen.tscn")
		get_tree().change_scene_to_packed(win_transition)
	pass
	
func _on_timer_timeout():
	print("spawn")
	spawn_enemy()
	pass

func spawn_enemy():  # Instance the enemy scene
	var enemy_instance = enemy_scene.instantiate()
	
	get_parent().add_child(enemy_instance) 
	enemy_instance.position = Vector2(1184,320)
	
	enemy_instance.connect("enemy_died", Callable(self, "_on_enemy_died"))
	print("Connected enemy_died signal to _on_enemy_died")
	pass
	
func _on_enemy_died(position): #detects when an enemy dies
	print("Enemy died at position: ", position) 
	print("kill count: ", enemy_manager.kill_count)
	
	
	pass

func _on_kill_count_updated(count): #depends on _on_enemy_died to print UI statement, check enemy_manager.gd script
	kill_count_label.text = "Mobs Slain: " + str(count)
	
	pass
	
	
func update_health_display(new_health: int):
	health_count_label.text = "Health Left: " + str(new_health)
	if new_health <= 0:
		health_count_label.modulate = Color(0.5, 0.5, 0.5)  # Grayout effect
		# Optionally trigger game over here if not handled in player script
	pass

func _on_start_timer_timeout() -> void:
	pass # Replace with function body.
	

func _on_quit_button_pressed() -> void:
	pass # Replace with function body.


func _on_main_title_button_pressed() -> void:
	pass # Replace with function body.
