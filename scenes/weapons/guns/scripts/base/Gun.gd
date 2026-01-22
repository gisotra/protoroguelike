@tool
class_name Gun
extends Node2D

@export_group("Gun Configurations")
@export var bullet_scene: PackedScene 
@export var shell_case_scene: PackedScene = preload(Constants.SCENE_PATHS.bullet_shell)
@export var gun_settings: GunSettings: 
	set(value):
		gun_settings = value
		setup_gun()
@export var on_floor: bool = false
### Essa variável é responsável por dar o offset preciso de onde ela deve estar deslocada no meu player
@export_group("Preferences")
@export var editor_anchor_pos: Vector2
@export var sprite_desired_offset: Vector2


# Gun-Related
@onready var gun_sprite: Sprite2D = $gun_sprite
@onready var muzzle: Marker2D = $muzzle
@onready var muzzle_flash: AnimatedSprite2D = $muzzleFlash
@onready var fire_rate_timer: Timer = $fire_rate_timer
@onready var interaction_component: InteractionComponent = $Interaction_Component

# Addons
@onready var camera: Camera2D = get_tree().get_first_node_in_group("Camera") #node global
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var type: GunSettings.gunType 
@onready var current_state: GunState = GunState.HANDLED

enum GunState {
	HANDLED, # Está ativa
	DROP,    # Está no chão
	STORED   # Player guardou
}

func _ready():
	setup_gun()
	interaction_component.interact = Callable(self, "_on_interact")
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if on_floor == true:
		current_state = GunState.DROP
		
	# LÓGICA DE CADA ESTADO DA ARMA
	match current_state:
### --------------------------------------- ARMA ATIVA NA MÃO DO PLAYER ---------------------------------------
		GunState.HANDLED:
			_manage_pos()
			interaction_component.monitoring = false
			#se a arma for semi-automatica:
			match type:
				GunSettings.gunType.SEMIAUTO:
					
					if Input.is_action_just_pressed("fire") and fire_rate_timer.is_stopped():
						shoot()
				GunSettings.gunType.AUTO:	#se a arma for semi-automatica
					if Input.is_action_pressed("fire") and fire_rate_timer.is_stopped():
						shoot()
			if gun_sprite.position.x < sprite_desired_offset.x:
				gun_sprite.position.x = lerp(gun_sprite.position.x, sprite_desired_offset.x, 10.0 * delta)
				
### --------------------------------------- ARMA NO CHÃO (pickable) ---------------------------------------
		GunState.DROP:
			interaction_component.monitoring = true
			gun_sprite.position = Vector2.ZERO
### --------------------------------------- ARMA NO INVENTÁRIO (switchable) ---------------------------------------
		GunState.STORED:
			pass

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
	#creation
	var shell_instance = shell_case_scene.instantiate()
	shell_instance.global_position = global_position
	shell_instance._initialize(gun_settings.life_time, gun_settings.shell_texture)

	#impulse ejection
	var eject_imp_X: float = randf_range(55 + gun_settings.ejection_speed, 155 + gun_settings.ejection_speed)
	var eject_imp_Y: float = randf_range(120 + gun_settings.ejection_speed, 205 + gun_settings.ejection_speed)
	shell_instance.apply_impulse(transform.x * -eject_imp_X, Vector2.ZERO) #HORIZONTAL
	shell_instance.apply_impulse(transform.y * -eject_imp_Y, Vector2.ZERO) #VERTICAL
	shell_instance.apply_torque_impulse(randf_range(-360, 360)) #ROTATION 
	
	return shell_instance

func _on_interact():
	if current_state == GunState.DROP:
		player.weapon_manager._pick_up_weapon(self) #ATRIBUIR MEU NODE DA ARMA (que está no chão) PARA O MEU PLAYER 

func _transition_to_handled():
	on_floor = false
	position = editor_anchor_pos
	gun_sprite.position = sprite_desired_offset
	current_state = GunState.HANDLED

func _transition_to_drop():
	on_floor = true
	gun_sprite.position = Vector2.ZERO
	current_state = GunState.DROP

func _transition_to_stored():
	on_floor = false
	gun_sprite.hide()
	current_state = GunState.STORED
