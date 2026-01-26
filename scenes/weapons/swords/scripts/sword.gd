@tool
extends Weapon
class_name Sword

@export var nomeDaEspada: String
@export var danoDaEspada: float
@export var spriteDaEspada: Texture2D: 
	set(value):
		spriteDaEspada = value
		_setup_sword()

@onready var sword_sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_setup_sword()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	

func _setup_sword():
	if sword_sprite:
		sword_sprite = spriteDaEspada.texture
	

#Override
func _transition_to_handled():
	on_floor = false
	#interaction_component.monitoring = false
	position = Vector2.ZERO
	sword_sprite.show()
	sword_sprite.position = Vector2.ZERO
	current_state = WeaponState.HANDLED

#Override
func _transition_to_drop():
	on_floor = true
	#interaction_component.monitoring = false
	sword_sprite.position = Vector2.ZERO
	rotation = 0.0
	scale.y = 1
	sword_sprite.show()
	current_state = WeaponState.DROP

#Override
func _transition_to_stored():
	on_floor = false
	#interaction_component.monitoring = false
	sword_sprite.hide()
	current_state = WeaponState.STORED
