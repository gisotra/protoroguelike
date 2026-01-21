@tool
extends Area2D
class_name InteractionComponent

@export var hover_sprite: Texture2D: 
	set(value):
		hover_sprite = value
		if is_node_ready():
			_sprite_setup()
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var action_name: String = "interact"
var show_sprite = false

func _ready() -> void:
	sprite_2d.scale = Vector2.ZERO

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return

var interact: Callable = func():
	pass
	
func _sprite_setup():
	sprite_2d = hover_sprite.texture

func _on_body_entered(body):
	var myTween = create_tween()
	myTween.set_parallel(true)
	myTween.set_ease(Tween.EASE_OUT)
	myTween.set_trans(Tween.TRANS_SPRING)
	myTween.tween_property(sprite_2d, "global_scale", Vector2(1.0, 1.0), 0.3)
	InteractionManager.register_area(self)

func _on_body_exited(body):
	var myTween = create_tween()
	myTween.set_parallel(true)
	myTween.set_ease(Tween.EASE_OUT)
	myTween.set_trans(Tween.TRANS_SPRING)
	myTween.tween_property(sprite_2d, "global_scale", Vector2.ZERO, 0.3)
	InteractionManager.unregister_area(self)
