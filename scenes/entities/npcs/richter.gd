extends Node2D

@onready var interaction_component: InteractionComponent = $InteractionComponent


#func _ready() -> void:
#	interaction_component.interact = Callable(self, "_on_interact")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_interact():
	print("omaga")
