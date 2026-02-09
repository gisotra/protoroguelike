extends StaticBody2D

@onready var health: HealthComponent = $HealthComponent
@onready var hurtbox: HurtboxComponent = $HurtboxComponent



func _process(delta: float) -> void:
	print(health.current_health)
	pass


func _on_health_component_on_die() -> void:
	print("boneco MORREU ")
	queue_free()
