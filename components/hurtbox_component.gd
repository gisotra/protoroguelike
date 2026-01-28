extends Node2D
class_name HurtboxComponent

@export var HealthComponent: PackedScene

"""tem a responsabilidade de receber dano dentro da sua área, e dar o signal pro healthManager, que 
vai falar 'ah, o elemento levou dano'"""



func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	
