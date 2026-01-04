extends CharacterBody2D

const SPEED = 150.0
const coeficiente_de_aceleracao = .15
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun: Gun = $Gun
const isWalking: bool = false

func _physics_process(delta: float) -> void:
	#handle the direction the player is facing
	_handle_direction()
	
	#handle movement
	var direction
	direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	
	var target_velocity: Vector2 = direction * SPEED
	
	#handles animation
	if direction != Vector2.ZERO:
		sprite.play("WALK")
	else:	#parado
		sprite.play("IDLE")
		
	#velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	velocity += (target_velocity - velocity) * coeficiente_de_aceleracao
	velocity = velocity.limit_length(SPEED)
	#limita a velocity
	move_and_slide()

func _handle_direction():
		#handle the direction the player is facing
	var distX
	distX = position.x - get_global_mouse_position().x
	if (distX >= 0): #looking to the right
		sprite.scale.x = -1
	else: #looking to the left
		sprite.scale.x = 1
