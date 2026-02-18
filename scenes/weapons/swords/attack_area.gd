extends Area2D
class_name SlashArea

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@export var damage: float

var direction = Vector2.ZERO

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("takeDamage"): # atingi um EnemyHurtbox
		body.takeDamage(damage, global_position, direction)
		player.velocity -= direction * 180 # aplico knockback no player
	else: # atingi uma parede ou qualquer objeto
		player.velocity -= direction * 180 # aplico knockback no player		
