extends Area2D

@export var camera: Node2D
@export var marker: Node2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		camera.camera_states = camera.states.GUIDED
		camera.position = lerp(camera.position, marker.position, 0.7)



func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		camera.camera_states = camera.states.AIM
