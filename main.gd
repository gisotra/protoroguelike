extends Node2D

@onready var pause_screen: CanvasLayer = $PauseScreen

var estaMostrando : bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausar"):
		estaMostrando = true
		pause() 

func pause():
	if estaMostrando == true:
		pause_screen.visible = true
	else:
		pause_screen.visible = false
