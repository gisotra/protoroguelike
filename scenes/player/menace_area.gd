extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("takeDamage"):
		body.Health.hb.show = true
	pass
	

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("takeDamage"):
		body.Health.hb.show = false
	pass
