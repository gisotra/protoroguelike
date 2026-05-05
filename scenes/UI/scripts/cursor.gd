extends Sprite2D
class_name MyCursor

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()


func _input(event: InputEvent) -> void:
	pass
