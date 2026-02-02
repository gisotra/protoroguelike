extends Sprite2D
class_name MyCursor

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		var myTween = create_tween()
		myTween.set_ease(Tween.EASE_OUT)
		myTween.set_trans(Tween.TRANS_CUBIC)
		myTween.tween_property(self, "global_scale", Vector2(1.3, 1.3), 0.15)
		myTween.tween_property(self, "global_scale", Vector2(1.0, 1.0), 0.15)
