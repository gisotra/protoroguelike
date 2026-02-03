extends AnimatableBody2D
class_name HurtboxComponent

@export var Health: HealthComponent


func takeDamage(object):
	Health._take_damage(object.damage)
	print(object.damage)

"""tem a responsabilidade de receber dano dentro da sua área, e dar o signal pro healthManager, que 
vai falar 'ah, o elemento levou dano X' """
