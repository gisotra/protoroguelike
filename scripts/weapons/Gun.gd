@tool
class_name Gun
extends Node2D

@export var bullet_scene: PackedScene
@export var shell_case_scene: PackedScene
@export var current_bullet_resource: BulletSettings 
@export var gun_settings: GunSettings: 
	set(value):
		gun_settings = value
		setup_gun()

@onready var gun_sprite: Sprite2D = $gun_sprite
@onready var muzzle: Marker2D = $muzzle
@onready var muzzle_flash: AnimatedSprite2D = $muzzleFlash
@onready var fire_rate_timer: Timer = $fire_rate_timer

@onready var camera: Camera2D = get_tree().get_first_node_in_group("Camera") #node global
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var type: GunSettings.gunType 

func _ready():
	setup_gun()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	_manage_pos()
	#se a arma for semi-automatica:
	match type:
		GunSettings.gunType.SEMIAUTO:
			
			if Input.is_action_just_pressed("fire") and fire_rate_timer.is_stopped():
				shoot()
		GunSettings.gunType.AUTO:	#se a arma for semi-automatica
			if Input.is_action_pressed("fire") and fire_rate_timer.is_stopped():
				shoot()
	if gun_sprite.position.x < 20:
		gun_sprite.position.x = lerp(gun_sprite.position.x, 20.0, 10.0 * delta)

func setup_gun():
	
	if gun_settings and gun_sprite:
		gun_sprite.texture = gun_settings.gun_texture
		muzzle_flash.sprite_frames = gun_settings.muzzle_flash_animation
		type = gun_settings.gun_type
		
func shoot():
	muzzle_flash.play("burst")
	camera.trigger_shake(gun_settings.shake_intensity)
	fire_rate_timer.start(gun_settings.fire_rate)
	_apply_recoil(gun_settings.recoil)
	_apply_knockback(gun_settings.player_knockback)
	_create_shell()
	
	
	for i in gun_settings.bullets_per_shot:
		get_tree().root.add_child(_create_bullet())
	for i in gun_settings.shell_amount:
		get_tree().root.add_child(_create_shell())
	
func _manage_pos():
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

func _create_bullet():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.settings = current_bullet_resource
	bullet_instance.global_position = muzzle.global_position
	#apply spread
	_apply_spread(bullet_instance, gun_settings.bullet_spread)
	return bullet_instance

func _apply_spread(bullet_instance, spread_value):
	bullet_instance.rotation = global_rotation + deg_to_rad(randi_range(-spread_value, spread_value))
	
func _apply_recoil(recoil_value):
	match type:
		GunSettings.gunType.SEMIAUTO:
			gun_sprite.position.x -= recoil_value
		GunSettings.gunType.AUTO:	#se a arma for semi-automatica
			gun_sprite.position.x -= recoil_value 

func _apply_knockback(knockback_value):
	player.velocity -= transform.x * knockback_value
	
func _create_shell():
	var shell_instance = shell_case_scene.instantiate()
	shell_instance.global_position = global_position
	shell_instance._initialize(gun_settings.life_time, gun_settings.shell_texture)
	return shell_instance
