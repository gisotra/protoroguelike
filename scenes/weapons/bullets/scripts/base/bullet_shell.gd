extends RigidBody2D
class_name BulletShell

@onready var spr_shell: Sprite2D = $spr_shell
@onready var death_timer: Timer = $Death_Timer
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var duration: float
@onready var shell_texture: Texture2D
@onready var new_point_floorY: float

func _initialize(tempoDeDuracao: float, sprite: Texture2D):
	duration = tempoDeDuracao
	shell_texture = sprite

func _ready():
	spr_shell.texture = shell_texture
	
	death_timer.wait_time = duration
	death_timer.start()
	new_point_floorY = global_position.y + randf_range(0, 30)
	
func _physics_process(delta: float):
	if position.y >= new_point_floorY:
		position.y = new_point_floorY
		
		if linear_velocity.y > 0: #caindo
			linear_velocity.y = -linear_velocity.y * 0.8
			linear_velocity.x = linear_velocity.x * 0.3

		if abs(linear_velocity.y) < 2:
			linear_velocity = Vector2.ZERO
			angular_velocity = 0 
			

func _on_death_timer_timeout() -> void:
	var myTween = create_tween()
	
	myTween.set_ease(Tween.EASE_OUT)
	myTween.set_trans(Tween.TRANS_CUBIC)
	myTween.tween_property(self, "scale", Vector2(1.3, 1.3), 0.5)
	myTween.tween_property(self, "scale", Vector2.ZERO, 0.9)
	await myTween.finished
	queue_free()
	
	
func _on_animation_player_animation_finished(anim_name: StringName):
	queue_free()
	print("adeus cabron")
