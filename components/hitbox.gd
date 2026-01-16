class_name Hitbox
extends Area2D
#Hitboxes are parts of an attack that can damage a character when they touch their hurtbox.
##Variável que aponta o dano causado ao player por colisão
@export var damage: int = 1 : set = set_damage, get = get_damage

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage
