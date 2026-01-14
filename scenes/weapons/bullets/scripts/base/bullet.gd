extends Area2D
class_name Bullet

@onready var bullet_texture: Sprite2D = $Sprite2D
@export var settings: BulletSettings
@onready var disappear_timer: Timer = $disappear_timer

func _ready() -> void:
	if settings:
		aplicar_configuracoes()

func aplicar_configuracoes():
	bullet_texture.texture = settings.texture
	disappear_timer.wait_time = settings.bullet_duration #cada bala tem um tempo próprio
	disappear_timer.start()
	

func _physics_process(delta):
	if settings:
		position += transform.x * settings.SPEED * delta

func _on_disappear_timer_timeout() -> void:
	queue_free()
