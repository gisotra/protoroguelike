extends Camera2D
class_name GameCamera

@export var player: Node2D

#Mouse Oriented Camera
var desired_offset: Vector2
var min_off_set = -50
var max_off_set = 50

#Shake
var shake_fade: float = 10.0
var shake_strength: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	desired_offset = (get_global_mouse_position() - position) * 0.5
	desired_offset.x = clamp(desired_offset.x, min_off_set, max_off_set)
	desired_offset.y = clamp(desired_offset.y, min_off_set / 2.0, max_off_set / 2.0)
	
	global_position = player.global_position + desired_offset
	#handles shaking
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, shake_fade * delta)
		offset = Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
		
func trigger_shake(max_shake: float):
	shake_strength = max_shake
	
