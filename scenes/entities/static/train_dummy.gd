extends CharacterBody2D

@onready var health: HealthComponent = $HealthComponent
@onready var hurtbox: HurtboxComponent = $HurtboxComponent



func _process(delta: float) -> void:
	print(health.current_health)
	pass
