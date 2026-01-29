extends Node2D
### Classe responsável pela lógica de manuseamento de armas (pistolas e espadas) do player 
class_name WeaponManager

### Normalmente cada player terá a Normal Pistol como arma primária, mas haverá casos especiais. 
@export var starting_weapon: PackedScene 

@onready var weapon_slots: Array[Weapon] = [ null, null ] 
@onready var current_slot_index: int
@onready var weapons_in_store: int = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("drop_weapon"):
		_drop_current_weapon(true)
	if Input.is_action_just_pressed("switch_weapons"):
		_switch_weapon()


func _ready():
	if starting_weapon:
		_pick_up_weapon(starting_weapon.instantiate())

func _pick_up_weapon(weapon: Weapon):
	if weapon.get_parent():
		weapon.reparent(self, false)
	else:
		add_child(weapon) #veio da memória (starting weapon)
		
	var empty_slot = weapon_slots.find(null)
	if empty_slot != -1: # inventário não está cheio
		weapon_slots[empty_slot] = weapon
		current_slot_index = empty_slot
	else: 
		_drop_current_weapon(false) 
		weapon_slots[current_slot_index] = weapon
	_update_weapon_states()

func _drop_current_weapon(should_switch: bool):
	var weapon_variable = weapon_slots[current_slot_index]
	if weapon_variable == null: #não tenho arma na minha mão (inventário tá vazio)
		return
	weapon_variable.reparent(get_parent().get_parent()) # nó avô
	weapon_variable._transition_to_drop()
	weapon_slots[current_slot_index] = null
	
	if should_switch and weapon_slots.has(null):
		var other_slot = 1 - current_slot_index
		if weapon_slots[other_slot] != null:
			current_slot_index = other_slot
			_update_weapon_states()

func _switch_weapon():
	if weapon_slots[0] == null or weapon_slots[1] == null:
		return 
	current_slot_index = 1 - current_slot_index # basicamente, inverto
	_update_weapon_states()


# array tools
func _number_of_weapons_in_inventory() -> int:
# ==== percorro o meu array ====
	var number_of_weapons_in_inventory = 0
	for element in weapon_slots:
		if element != null:
			number_of_weapons_in_inventory += 1
	return number_of_weapons_in_inventory

func _which_weapon_slot_is_free() -> int:
	var weapon_index: int
	weapon_index = weapon_slots.find(null)
	return weapon_index

func _update_weapon_states():
	for i in range(weapon_slots.size()):
		var weapon = weapon_slots[i]
		if weapon != null:
			if i == current_slot_index:
				weapon._transition_to_handled()
			else:
				weapon._transition_to_stored()
		
