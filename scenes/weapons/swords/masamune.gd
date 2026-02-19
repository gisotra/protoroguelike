extends Sword

@onready var slash_area: SlashArea = $SlashArea

func _attack():
	slash_area.direction = (get_global_mouse_position() - global_position).normalized()
	#player.velocity += slash_area.direction * 180
	animation_player.play("attack")
