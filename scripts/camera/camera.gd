extends Camera2D
@onready var player: CharacterBody2D = %player

var desired_offset: Vector2
var min_off_set = -50
var max_off_set = 50

var noise = FastNoiseLite.new()
var shake_intensity: float = 0.0
var activate_shake_time: float = 0.0

var shake_decay: float = 5.0

var shake_time_speed: float = 20.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	desired_offset = (get_global_mouse_position() - position) * 0.5
	desired_offset.x = clamp(desired_offset.x, min_off_set, max_off_set)
	desired_offset.y = clamp(desired_offset.y, min_off_set / 2.0, max_off_set / 2.0)
	
	global_position = player.global_position + desired_offset

func _shake():
	randomize()
	noise.seed = randi()
