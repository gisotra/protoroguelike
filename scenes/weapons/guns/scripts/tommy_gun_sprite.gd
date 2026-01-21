extends Sprite2D

@onready var tommy_gun: Gun = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tommy_gun.current_state == tommy_gun.GunState.HANDLED:
		z_index = -1
