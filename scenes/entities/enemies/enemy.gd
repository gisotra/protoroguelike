extends CharacterBody2D
class_name Enemy

@onready var hurtbox: HurtboxComponent = $HurtboxComponent
@onready var health: HealthComponent = $HealthComponent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_health_component_on_die() -> void:
	queue_free()
