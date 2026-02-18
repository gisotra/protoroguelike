extends Sword

@onready var slash_area: SlashArea = $SlashArea
var return_to_place: bool = false

func _physics_process(delta: float) -> void:
	if WeaponState.HANDLED:
		var target_angle = (get_global_mouse_position() - global_position).angle()
		if return_to_place and sword_sprite.rotation != target_angle:
			sword_sprite.rotation = lerp_angle(sword_sprite.rotation, target_angle, 100* delta)

func _attack():
	slash_area.direction = (get_global_mouse_position() - global_position).normalized()
	animation_player.play("attack")
	"""
	é responsabilidade da espada decidir a DIREÇÃO daquele slash, o slash nao sabe "pra onde ele está olhando" 
	
	"""
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	return_to_place = true
