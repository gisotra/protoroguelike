extends CharacterBody2D
class_name Player

@export var SPEED = 150.0
@export_range(1, 10) var HEALTH : int
 
const coeficiente_de_aceleracao = .15
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var isWalking: bool = false
@onready var dust: GPUParticles2D = $dust
@onready var central_head_point: Marker2D = $central_head_point
@onready var frame_count: int = 0
@onready var weapon_manager: Node2D = $WeaponManager

func _physics_process(delta: float) -> void:
	frame_count += 1
	#handle the direction the player is facing
	_handle_direction()
	
	#handle movement
	var direction
	direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	var target_velocity: Vector2 = direction * SPEED
	
	#handles animation
	if direction != Vector2.ZERO:
		isWalking = true
		sprite.play("WALK")
		if direction.x == -sprite.scale.x:
			sprite.play_backwards("WALK")
		
	else:	#parado
		isWalking = false
		sprite.play("IDLE")
	
	#velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	velocity += (target_velocity - velocity) * coeficiente_de_aceleracao
	velocity = velocity.limit_length(SPEED)
	
	#limita a velocity
	if isWalking:
		dust.emitting = true
	else:
		dust.emitting = false
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = true

func _handle_direction():
		#handle the direction the player is facing
	var distX
	distX = position.x - get_global_mouse_position().x
	if (distX >= 0): #looking to the right
		sprite.scale.x = -1
		central_head_point.scale.x = -1
	else: #looking to the left
		sprite.scale.x = 1
		central_head_point.scale.x = 1
		
