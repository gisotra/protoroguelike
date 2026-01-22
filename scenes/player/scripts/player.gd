extends CharacterBody2D
class_name Player

const SPEED = 150.0
const coeficiente_de_aceleracao = .15
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var eyes: Sprite2D = $eyes
@onready var gun: Gun = $Gun
var isWalking: bool = false
@onready var dust: GPUParticles2D = $dust
@onready var central_head_point: Marker2D = $central_head_point
@onready var frame_count: int = 0
@onready var eyes_update_rate = 10

@onready var weapon_array: Array[Gun] = [ null, null ] 
@onready var current_weapon: Gun

func _physics_process(delta: float) -> void:
	frame_count += 1
	#handle the direction the player is facing
	_handle_direction()
	
	"""if frame_count % eyes_update_rate:
		eyes._update_eyes_pos()
		frame_count = 0"""
	
	#handle movement
	var direction
	direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	
	var target_velocity: Vector2 = direction * SPEED
	
	#handles animation
	if direction != Vector2.ZERO:
		isWalking = true
		sprite.play("WALK")
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

func _handle_direction():
		#handle the direction the player is facing
	var distX
	distX = position.x - get_global_mouse_position().x
	if (distX >= 0): #looking to the right
		sprite.scale.x = -1
		eyes.scale.x = -1
		central_head_point.scale.x = -1
	else: #looking to the left
		sprite.scale.x = 1
		eyes.scale.x = 1
		central_head_point.scale.x = 1
		
func _pick_up_weapon(weapon: Gun):
	"""
	a função desse Pick Up Weapon vai ser:
		Adicionar a arma no meu arraylist (para armazenar essa informação)
		Settar que o nó pai dessa arma é o player
		Alterar o estado e a posição dela na minha mão
	"""
	weapon_array.append(gun)
	weapon.reparent(self, false)
	weapon._transition_to_handled()
	current_weapon = weapon
	
func _drop_weapon(gun: Gun):

	pass
	
func _switch_weapon():
	if weapon_array.is_empty(): # não tenho nenhuma arma
		return
	if weapon_array.size() == 1: # só tenho 1 arma
		return
	
