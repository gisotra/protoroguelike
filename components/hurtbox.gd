class_name Hurtbox
extends Area2D
#Hurtboxes are parts of a character's body that can be damaged when they touch a hitbox.

signal received_damage(damage: int)

@export var healthData: HealthComponent

func _ready():
	connect("area_entered", on_area_entered)

func on_area_entered(hitbox: Area2D) -> void:
	if hitbox != null:
		healthData.current_health -= hitbox.damage
		healthData.on_change.emit(healthData.current_health, healthData.max)
		
		received_damage.emit(hitbox.damage)

##NOT FINISHED
