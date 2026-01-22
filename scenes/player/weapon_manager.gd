extends Node2D

@onready var weapon_array: Array[Gun] = [ null, null ] 
@onready var current_weapon: Gun

func _pick_up_weapon(weapon: Gun):
	weapon_array.append(weapon)
	weapon.reparent(self, false)
	weapon._transition_to_handled()
	current_weapon = weapon

func _drop_weapon(weapon: Gun):
	pass

func _switch_weapon():
	if weapon_array.is_empty(): # não tenho nenhuma arma
		return
	if weapon_array.size() == 1: # só tenho 1 arma
		return
