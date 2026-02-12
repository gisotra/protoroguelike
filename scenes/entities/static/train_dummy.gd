extends Enemy

@onready var hit_fx: GPUParticles2D = $hit_FX


func _on_enemy_hurtbox_collided(damage, pos, knockback_vec) -> void:
	hit_fx.rotation = knockback_vec.angle()
	hit_fx.emitting = true
