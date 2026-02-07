extends Node2D
@onready var camera: Camera2D = get_tree().get_first_node_in_group("Camera") #node global

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.trigger_shake(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
