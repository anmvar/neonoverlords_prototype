extends CharacterBody2D

signal player_hit

var screen_size
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d = $Irabel_Sprite2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var sprite = Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#$Irabel_AnimationPlayer.play("irabel_idle")
	#$Irabel_AnimationPlayer.play("irabel_idle")
	$Irabel_Sprite2D/JumpParticles.emitting = false
	add_to_group("player")
	#$Irabel_AnimationPlayer.play("Irabel_basicattack")
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

func _on_hit_player() -> void:
	pass # Replace with function body.
