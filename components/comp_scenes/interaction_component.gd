extends Area2D
class_name InteractionComponent

@export var hover_sprite: Texture2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var interact: Callable = func():
	pass

func _on_body_entered(body):
	InteractionManager.register_area(self)
	

func _on_body_exited(body):
	InteractionManager.unregister_area(self)
