extends Node
var enemy_scene = preload("res://purple_enemy.tscn")#.instantiate()  # Path to your enemy scene
@onready var kill_count_label: Label = $CanvasLayer/Control/KillCountLabel


func _ready():  
	print("spawn on")
	var timer = $Timer
	print("Timer node:", timer) 
	timer.stop()
	timer.start()  
	print("Timer started:", timer.is_stopped()) 
	enemy_manager.connect("kill_count_updated", Callable(self, "_on_kill_count_updated"))
	pass
	
func _process(float) -> void:
	pass
	
func _on_timer_timeout():
	print("spawn")
	spawn_enemy()
	pass

func spawn_enemy():  # Instance the enemy scene
	var enemy_instance = enemy_scene.instantiate()
	
	get_parent().add_child(enemy_instance) 
	enemy_instance.position = Vector2(1000,200)
	
	enemy_instance.connect("enemy_died", Callable(self, "_on_enemy_died"))
	print("Connected enemy_died signal to _on_enemy_died")
	pass
	
func _on_enemy_died(position):
	print("Enemy died at position: ", position) 
	print("kill count: ", enemy_manager.kill_count)
	pass

func _on_kill_count_updated(count):
	kill_count_label.text = "Mobs Slain: " + str(count)
	pass

func _on_start_timer_timeout() -> void:
	pass # Replace with function body.
	
	
