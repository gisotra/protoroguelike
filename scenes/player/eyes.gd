extends Sprite2D

@export var central_head_point: Node2D
@onready var position_offset: Vector2
@onready var max_off_set_x = 1.5
@onready var max_off_set_y: = 0.5
@onready var smooth_speed = 7


func _process(delta: float) -> void:
	if !central_head_point:
		return
	var mouse_global = get_global_mouse_position()
	var head_point = central_head_point.global_position
	var diff = mouse_global - head_point
	diff.x = clamp(diff.x, -max_off_set_x, max_off_set_x)
	diff.y = clamp(diff.y, -max_off_set_y, max_off_set_y)
	
	var target_position = head_point + diff
	global_position = global_position.lerp(target_position, smooth_speed * delta)
	
	
