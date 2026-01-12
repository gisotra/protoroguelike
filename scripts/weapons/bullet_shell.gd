extends RigidBody2D
class_name BulletShell

@onready var spr_shell: Sprite2D = $spr_shell
@onready var death_timer: Timer = $Death_Timer
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var duration: float
@onready var shell_texture: Texture2D

func _initialize(tempoDeDuracao: float, sprite: Texture2D):
	duration = tempoDeDuracao
	shell_texture = sprite
	if duration and shell_texture:
		print("capsula configurada!")

func _ready():
	#anim_player.play("birth")	
	spr_shell.texture = shell_texture
	death_timer.wait_time = duration
	death_timer.start()

	
	
	

	
