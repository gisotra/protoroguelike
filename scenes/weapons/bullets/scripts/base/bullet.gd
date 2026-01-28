@tool
extends CharacterBody2D
class_name Bullet

@onready var bullet_texture: Sprite2D = $Sprite2D
@export_group("Configurações da Bala")
@export var damage_on_contact: float
@export var base_speed: float
@export var speed_curve: Curve
@export var duration: float
@export var bullet_sprite: Texture2D: 
	set(value):
		bullet_sprite = value
		show_in_editor()
@export var impact_on_flesh: PackedScene
@export var impact_on_wall: PackedScene
@onready var disappear_timer: Timer = $disappear_timer

var direction = Vector2.ZERO

#manutenção da velocidade com base no gráfico
var time_elapsed: float = 0.0

func _ready() -> void:
	if Engine.is_editor_hint():
		show_in_editor() 
		return
	aplicar_configuracoes()

func aplicar_configuracoes():
	bullet_texture.texture = bullet_sprite
	disappear_timer.wait_time = duration #cada bala tem um tempo próprio
	disappear_timer.start()

func show_in_editor(): 
	if bullet_texture:
		bullet_texture.texture = bullet_sprite

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	time_elapsed += delta
	var collision_result = move_and_collide(direction * base_speed * delta)
	if collision_result != null:
		queue_free()

func _on_disappear_timer_timeout() -> void:
	queue_free()
