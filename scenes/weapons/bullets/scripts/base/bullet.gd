@tool
extends CharacterBody2D
class_name Bullet

@onready var bullet_texture: Sprite2D = $Sprite2D
@export_group("Configurações da Bala")
@export var damage: float
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
	# Speed Curve treatment
	time_elapsed += delta 
	var current_speed = base_speed
	
	if speed_curve: 
		var t = clamp(time_elapsed / duration, 0.0, 1)
		current_speed = base_speed * speed_curve.sample(t)
	
	var collision_result = move_and_collide(direction * current_speed * delta)
	if collision_result != null:
		var target = collision_result.get_collider() 
		
		if target.name == "EnemyHurtbox":
			IMPACT_FX_FLESH(collision_result)
			var enemy_target = target.owner
			enemy_target.health._take_damage(damage)
		else:
			IMPACT_FX_WALL()
			print("Atingi o muro")
		queue_free()

func IMPACT_FX_WALL():
	if impact_on_wall == null:
		return
	var impact_wall_FX = impact_on_wall.instantiate()
	get_parent().add_child(impact_wall_FX)
	impact_wall_FX.global_position = global_position 
	pass

func IMPACT_FX_FLESH(cr): 
	if impact_on_flesh == null: # não tem
		return
	var impact_flesh_FX = impact_on_flesh.instantiate()
	get_parent().add_child(impact_flesh_FX)
	impact_flesh_FX.global_position = cr.get_position()

	
	
func _on_disappear_timer_timeout() -> void:
	queue_free()	
