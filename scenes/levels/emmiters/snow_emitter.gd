extends Node2D
class_name SnowEmmiter

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@export var player: Node2D

func _ready():
	gpu_particles_2d.emitting = true
	
func _process(delta: float) -> void:
	global_position.x = player.global_position.x 
	global_position.y = player.global_position.y - 120
