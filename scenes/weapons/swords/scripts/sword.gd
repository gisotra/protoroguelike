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

# Sword-Related
@onready var sword_sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interaction_component: InteractionComponent = $InteractionComponent

# Addons
@onready var camera: Camera2D = get_tree().get_first_node_in_group("Camera") #node global
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

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
### --------------------------------------- ARMA NO CHÃO (pickable) ---------------------------------------
		WeaponState.DROP:
			interaction_component.monitoring = true
			sword_sprite.position = Vector2.ZERO
### --------------------------------------- ARMA NO INVENTÁRIO (switchable) ---------------------------------------
		WeaponState.STORED:
			pass

func _setup_sword():
	if swordData and sword_sprite:
		sword_sprite.texture = swordData.sword_sprite


func _on_interact():
	if current_state == WeaponState.DROP:
		player.weapon_manager._pick_up_weapon(self) #ATRIBUIR MEU NODE DA ARMA (que está no chão) PARA O MEU PLAYER 

#  Weapon Class Overrided Methods

func _manage_pos():
	look_at(get_global_mouse_position())
	
	# apenas inverte a sprite 
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
	current_state = WeaponState.DROP

#Override
func _transition_to_stored():
	on_floor = false
	interaction_component.monitoring = false
	sword_sprite.hide()
	current_state = WeaponState.STORED
