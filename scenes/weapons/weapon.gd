extends Node2D
class_name Weapon
@export var on_floor: bool = false
# Universal para cada arma
@onready var current_state: WeaponState = WeaponState.HANDLED

enum WeaponState {
	HANDLED, # Está ativa
	DROP,    # Está no chão
	STORED   # Player guardou
}

func _manage_pos():
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

#Overridable
func _transition_to_handled():
	pass

#Overridable
func _transition_to_drop():
	pass

#Overridable
func _transition_to_stored():
	pass
