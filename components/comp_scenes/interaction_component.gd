extends Area2D

@export var hover_sprite: Texture2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_player.play("RESET")
