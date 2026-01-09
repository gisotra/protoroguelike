@tool
extends Area2D
class_name Gate

@export var LocationDestiny: String = ""
@export var SpriteAnimation: SpriteFrames:
	set(value):
		SpriteAnimation = value
		_setup_gate()
@onready var gate_sprite: AnimatedSprite2D = $gate_sprite
@onready var gate_collision: CollisionShape2D = $gate_collision


func _ready() -> void:
	if not Engine.is_editor_hint():
		self.body_entered.connect(_on_body_entered)
	else:
		_setup_gate()

func _on_body_entered(body: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file", LocationDestiny)

func _setup_gate():
	if gate_sprite and SpriteAnimation:
		gate_sprite.sprite_frames = SpriteAnimation
		
