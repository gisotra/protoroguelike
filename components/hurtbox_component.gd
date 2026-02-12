extends AnimatableBody2D
class_name HurtboxComponent

@export var Health: HealthComponent
@onready var hit_particles: Node2D = $hit_particles
@onready var hit_fx: GPUParticles2D = $hit_FX

signal collided(damage, pos, knockback_vec)

func takeDamage(damage, pos, knockback_vec):
	Health._take_damage(damage)
	emit_signal("collided", damage, pos, knockback_vec)

"""tem a responsabilidade de receber dano dentro da sua área, e dar o signal pro healthManager, que 
vai falar 'ah, o elemento levou dano X' """
