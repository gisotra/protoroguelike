@tool
extends Weapon
class_name Sword

@export_group("Sword Configurations")
@export var swordData: SwordSettings: 
	set(value):
		swordData = value
		_setup_sword()
		
### Essa variável é responsável por dar o offset preciso de onde ela deve estar deslocada no meu player quando HANDLED
@export_group("Preferences")
@export var editor_anchor_pos: Vector2
@export var sprite_desired_offset: Vector2

## Frescura que eu fiz pra arma apontar pro mouse com spring-lerp
@export_group("Sword Swing")
## o quão pesada aquela espada é
@export var weight: float 

# Sword-Related
@onready var sword_sprite: Sprite2D = $sword_sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var outline: Sprite2D = $sword_sprite/outline
@onready var shine_drop: GPUParticles2D = $sword_sprite/shine_drop

# Addons
@onready var camera: Camera2D = get_tree().get_first_node_in_group("Camera") #node global
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

@onready var attacking: bool = false
var velocidade = 0.0

func _ready() -> void:
	_setup_sword()

	
	interaction_component.interact = Callable(self, "_on_interact")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if on_floor == true:
		current_state = WeaponState.DROP
		
	# LÓGICA DE CADA ESTADO DA ARMA
	match current_state:
### --------------------------------------- ARMA ATIVA NA MÃO DO PLAYER ---------------------------------------
		WeaponState.HANDLED:
			_manage_pos()
			if Input.is_action_just_pressed("fire"):
				animation_player.play("attack1")
### --------------------------------------- ARMA NO CHÃO (pickable) ---------------------------------------
		WeaponState.DROP:
			interaction_component.monitoring = true
			sword_sprite.position = Vector2.ZERO
			
### --------------------------------------- ARMA NO INVENTÁRIO (switchable) ---------------------------------------
		WeaponState.STORED:
			pass

func _setup_sword():
	if swordData and sword_sprite and outline_sprite:
		sword_sprite.texture = swordData.sword_sprite
		outline.texture = outline_sprite

func _on_interact():
	if current_state == WeaponState.DROP:
		player.weapon_manager._pick_up_weapon(self) #ATRIBUIR MEU NODE DA ARMA (que está no chão) PARA O MEU PLAYER 

#  Weapon Class Overrided Methods

func _manage_pos():
	"""
	# eu pego ONDE é o meu alvo de direção
	var target_angle = (get_global_mouse_position() - global_position).angle()
	
	# pego a direção entre o meu ângulo atual pra onde eu quero ir
	var angle_diff = angle_difference(rotation, target_angle)
	
	# a velocidade de pegada a cada frame é calculada pela minha diferença de ângulos * a força do pulso,
	# isso foi usado porque eu queria atingir um efeito de mola, que tem como conceito principal a 
	# dificuldade em atingir a velocidade suficiente pra chegar no ponto desejado, acelerar, e PASSAR RETO
	# pelo ponto desejado, e ter que recuar pra atingir o objetivo 
	var desired_angular_speed = angle_diff * wrist_strength
	
	
	velocidade = lerp(velocidade, desired_angular_speed, lightness)
	rotation += velocidade
	
	if abs(rotation) > PI / 2: 
		scale.y = -1 
	else:
		scale.y = 1
	"""

	var target_angle = (get_global_mouse_position() - global_position).angle()
	rotation = lerp_angle(rotation, target_angle, weight * get_process_delta_time())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

#Override
func _transition_to_handled():
	on_floor = false
	interaction_component.monitoring = false
	position = editor_anchor_pos
	sword_sprite.show()
	outline.hide()
	shine_drop.emitting = false
	sword_sprite.position = sprite_desired_offset
	current_state = WeaponState.HANDLED

#Override
func _transition_to_drop():
	on_floor = true
	interaction_component.monitoring = false
	sword_sprite.position = Vector2.ZERO
	rotation = 0.0
	scale.y = 1
	sword_sprite.show()
	outline.show()
	shine_drop.emitting = true
	current_state = WeaponState.DROP

#Override
func _transition_to_stored():
	on_floor = false
	interaction_component.monitoring = false
	sword_sprite.hide()
	outline.hide()
	shine_drop.emitting = false
	current_state = WeaponState.STORED
