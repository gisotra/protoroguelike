extends Enemy
class_name Dummy

@onready var time_to_heal: Timer = $time_to_heal
@onready var hit_fx: GPUParticles2D = $hit_FX


func _process(delta: float) -> void :
	if health.current_health < health.maxHealth and time_to_heal.is_stopped():
		print("current health: ", health.current_health)
		print("max health: ", health.maxHealth)
		health.heal(0.8)
		

func _on_enemy_hurtbox_collided(damage, pos, knockback_vec) -> void:
	hit_fx.rotation = knockback_vec.angle()
	hit_fx.emitting = true
	time_to_heal.start(3)
	
