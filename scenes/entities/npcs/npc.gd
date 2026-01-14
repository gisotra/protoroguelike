extends Node2D

@onready var interaction_component: InteractionComponent = $Interaction_Component

func _ready() -> void:
	interaction_component.interact = Callable(self, "_on_interact")

func _on_interact():
	
	print("hello peter")
