extends StaticBody2D

@onready var health: HealthComponent = $HealthComponent
@onready var hurtbox: HurtboxComponent = $HurtboxComponent



func _process(delta: float) -> void:
	print("Hp do boneco: ", health.current_health)
	pass
