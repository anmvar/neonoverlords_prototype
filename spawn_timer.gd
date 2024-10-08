#extends Timer  # or whatever node type you're using
#
#var enemy_scene = preload("res://mobtest.tscn")  # Path to your enemy scene
#
#
#func _ready():
	#print("spawn on")
	#var timer = $"../Timer"
	#print("Timer node:", timer) 
	#timer.stop()
	#timer.start()  # Start the timer
	#print("Timer started:", timer.is_stopped()) 
#
#func _on_timer_timeout():
	#print("spawn")
	#spawn_enemy()
#
#func spawn_enemy():
	#var enemy = enemy_scene.instance()  # Instance the enemy scene
	#enemy.position = Vector2(265,151)
	#get_parent().add_child(enemy)  # Add the enemy to the scene
	#print("spawned at:", enemy.position)
