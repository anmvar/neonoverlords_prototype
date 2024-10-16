extends CharacterBody2D

var screen_size
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d = $Irabel_Sprite2D
var player_health = 3
var player_is_invulnerable = false

const SPEED = 350.0
const JUMP_VELOCITY = -450.0
const KNOCKBACK_FORCE = 500
const FLASH_TIME = 0.2  # Duration of flash
const FLASH_COLOR = Color(1, 0, 0)  # Red color for flash

@export var sprite = Sprite2D

func _ready():
	screen_size = get_viewport_rect().size
	$Irabel_Sprite2D/JumpParticles.emitting = false
	add_to_group("player")
	pass

func _process(_delta):
	
	if Input.is_action_just_pressed("attack_basic"):
		$Irabel_AnimationPlayer.play("Irabel_basicattack")
	
		print("attack")
	if not $Irabel_AnimationPlayer.is_playing():
		$Irabel_AnimationPlayer.play("irabel_idle")

func _physics_process(delta):
	velocity.x = 0

	
	if not is_on_floor():
		
		velocity.y +=  delta * gravity
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Irabel_AnimationPlayer.play("irabel_jump")
		
	var direction = Input.get_axis("move_left","move_right")
	velocity.x = direction * SPEED
	if direction > 0.1:
		sprite_2d.flip_h = false
		
	elif direction < -0.1:
		sprite_2d.flip_h = true
		
	if velocity.x != 0 and is_on_floor and velocity.y == 0:
		$Irabel_AnimationPlayer.play("irabel_run")
	
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		$Irabel_AnimationPlayer.play("irabel_idle")
		
	if not $Irabel_AnimationPlayer.is_playing():
			$Irabel_AnimationPlayer.play("irabel_idle")
			
	if Input.is_action_just_pressed("jump") or Input.is_action_just_released("jump") :
			$Irabel_AnimationPlayer.play("irabel_jump")

	move_and_slide()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled",true)
	pass


func _on_irabel_area_body_entered(body: CharacterBody2D) -> void:
	
	pass # Replace with function body.


func _on_irabel_area_entered(area: Area2D) -> void:
	print ("something entered irabel area")
	if area.is_in_group("enemy_damage"):
		_player_takes_damage(area)
	pass # Replace with function body.

func _player_takes_damage(area: Area2D):
	if not player_is_invulnerable:
		player_is_invulnerable = true
		player_health -= 1
		
		print("current health: ", player_health)
		
		get_node("/root/Node").update_health_display(player_health)
		
		# Flash effect
		await flash_red()
		
		# Reset invulnerability after a short delay
		await get_tree().create_timer(1.0).timeout  # Adjust delay as needed
		player_is_invulnerable = false
		
		if player_health <= 0:
			print("Irabel dead")
			await get_tree().create_timer(0.25).timeout 
			get_tree().paused = true
			get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
		
		
		pass


func flash_red():
	var original_color = sprite_2d.modulate
	sprite_2d.modulate = FLASH_COLOR
	await get_tree().create_timer(FLASH_TIME).timeout
	sprite_2d.modulate = original_color
