extends Node
class_name HealthComponent

signal on_change(current : int, max : int)
signal on_take_damage()
signal on_die()

enum PostDeath {
	DestroyNode, 
	RestartScene
}

var current_health : int 
@export var max : int 
@export var post_death_action : PostDeath
@export var drop_on_death : PackedScene

func _ready():
	current_health = max 
	
func _take_damage(damage : int):
	current_health -= damage
	on_change.emit(current_health, max)
	on_take_damage.emit()
	
	if current_health <= 0:
		die()
	
func die():
	on_die.emit()
	
	if drop_on_death != null:
		pass #implemento depois
		#var drop = drop_on_death.instantiate()
		#get_node("/root/").add_child(drop)
		
	if post_death_action == PostDeath.DestroyNode:
		get_parent().queue_free()
	elif post_death_action == PostDeath.RestartScene:
		get_tree().reload_current_scene()

func heal(amount: int):
	current_health += amount
	if current_health > max:
		current_health = max
		
	on_change.emit(current_health, max)
