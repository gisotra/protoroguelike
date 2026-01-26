extends Node
class_name HealthComponent

signal on_change(current : int, max : int)
signal on_take_damage()

var current_health : int 
@export var max : int 
@export var drop_on_death : PackedScene

func _ready():
	current_health = max 
	
func _take_damage(damage : int):
	current_health -= damage
	on_change.emit(current_health, max)
	on_take_damage.emit()	

func heal(amount: int):
	current_health += amount
	if current_health > max:
		current_health = max
		
	on_change.emit(current_health, max)
