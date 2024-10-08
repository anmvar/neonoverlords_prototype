extends CharacterBody2D
#signal hit_mob
signal enemy_died 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	  # Ensure it's not emitting at start
	#if not $PurpleMob_AnimationPlayer.is_playing():
		#$Purplemob_AnimationPlayer.play("purplemob_idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	#
	move_and_slide()
	pass




func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox"):
		print("Enemy died at position: ", position) 
		queue_free()
		
	pass # Replace with function body.
	
	


func _on_enemy_died() -> void:
	
	pass # Replace with function body.
