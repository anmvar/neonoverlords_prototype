extends CharacterBody2D
#signal hit_mob
signal enemy_died(position)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var mob_sprite_2d = $PurpleMob_Sprite2D
@onready var mob_move_timer = $MoveTimer
@onready var aggro_area: Area2D = $AggroArea #area to detect whwen player enters

# Movement parameters
var speed = 150  # Speed of the enemy
var distance = 100  # Distance to move back and forth
var direction = 1.0  # Current moving direction  # Timer to track movement time
var start_position: Vector2  # The starting position of the enemy
var leap_speed = 400
var mob_is_attacking = false
var enemy_dead = false
# Called when the node enters the scene tree for the first time.

func _ready():
	start_position = position 
	if not $PurpleMob_AnimationPlayer.is_playing():
		$PurpleMob_AnimationPlayer.play("purplemob_idle")
	
	aggro_area.connect("area_entered", Callable(self, "_on_aggro_area_entered"))
	start_direction_change_timer()
	
	pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if mob_is_attacking:
		# Move towards the player during the attack
		var player_position = get_node("/root/Node/Player").position  # Change to your player's node path
		var direction_to_player = (player_position - position).normalized()
		velocity = direction_to_player * leap_speed
	else:
		if velocity.x != 0 and $PurpleMob_AnimationPlayer.get_current_animation() != "purplemob_attack":
			$PurpleMob_AnimationPlayer.play("purplemob_walk")
		
		if not is_on_floor():
			velocity.y += gravity * delta
		else:
			velocity.y = 0 

		mob_sprite_2d.flip_h = (direction > 0)

		velocity.x = direction * speed 
	
	move_and_slide()
	pass

func start_direction_change_timer():
	var random_time = randf_range(1,2)
	mob_move_timer.wait_time = random_time
	mob_move_timer.start()

func _on_move_timer_timeout() -> void:
	direction *= -1  # Reverse the direction
	start_direction_change_timer()
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox") and not enemy_dead: 
		enemy_dead = true
		emit_signal("enemy_died",position)
		enemy_manager.increase_kill_count() 
		queue_free()
	pass # Replace with function body.
	
func _on_enemy_died() -> void:
	
	pass # Replace with function body.


func _on_aggro_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):  # Check if the area belongs to the player group
		print("mob animation check")
		if $PurpleMob_AnimationPlayer.get_current_animation() != "purplemob_attack" and not mob_is_attacking:
			mob_is_attacking = true
			print("playing attack animation")
			$PurpleMob_AnimationPlayer.stop()
			$PurpleMob_AnimationPlayer.play("purplemob_attack")
			await $PurpleMob_AnimationPlayer.animation_finished
			print("attack animation finished")
			mob_is_attacking = false
		else:
			print("Attack animation already playing")
	print("mob sees player")
	pass # Replace with function body.

#func attack_player():
	#$PurpleMob_AnimationPlayer.play("purplemob_attack")
	#pass
