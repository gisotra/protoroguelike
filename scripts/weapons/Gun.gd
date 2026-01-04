@tool
class_name Gun
extends Node2D

@export var bullet_scene: PackedScene
@export var current_bullet_resource: BulletSettings 
@export var gun_settings: GunSettings: 
	set(value):
		gun_settings = value
		setup_gun()
@onready var gun_sprite: Sprite2D = $gun_sprite
@onready var muzzle: Marker2D = $muzzle
@onready var muzzle_flash: AnimatedSprite2D = $muzzleFlash

func _ready():
	setup_gun()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	_manage_pos()
	if Input.is_action_just_pressed("fire"):
		shoot()

func setup_gun():
	if gun_settings and gun_sprite:
		gun_sprite.texture = gun_settings.gun_texture
		muzzle_flash.sprite_frames = gun_settings.muzzle_flash_animation

func shoot():
	muzzle_flash.play("burst")
	for i in gun_settings.bullets_per_shot:
		#crio 1 bala
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.settings = current_bullet_resource
		bullet_instance.global_position = muzzle.global_position
		#apply spread
		_apply_spread(bullet_instance, gun_settings.bullet_spread)
		
		#libero ela pro mundão 
		get_tree().root.add_child(bullet_instance)

	
func _manage_pos():
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
		
func _apply_spread(bullet_instance, spread_value):
	bullet_instance.rotation = global_rotation + deg_to_rad(randi_range(-spread_value, spread_value))
	
	
	
