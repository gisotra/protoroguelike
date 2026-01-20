extends Area2D

@export var player: Node2D
@export var camera: Node2D
@export var marker: Node2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		camera.camera_states = camera.states.GUIDED
		var myTween = create_tween()
		myTween.set_parallel(true)
		myTween.set_ease(Tween.EASE_IN)
		myTween.set_trans(Tween.TRANS_LINEAR)
		myTween.tween_property(camera, "global_position:y", marker.global_position.y, 1.2)
		#myTween.tween_property(camera, "zoom", Vector2(1.2, 1.2), 1.2)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		var myTween = create_tween()
		myTween.set_parallel()
		myTween.set_ease(Tween.EASE_OUT)
		myTween.set_trans(Tween.TRANS_LINEAR)
		myTween.tween_property(camera, "global_position:y", player.global_position.y, 1.2)
		#myTween.tween_property(camera, "zoom", Vector2(2.0, 2.0), 1.2)
		
		await myTween.finished
		camera.camera_states = camera.states.AIM
