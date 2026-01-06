extends Resource
class_name GunSettings

@export_group("General Configurations")
@export var weapon_name: String
@export var ammo_cap: int
@export var fire_rate: float
@export var bullet_spread: float
@export var bullets_per_shot: int
@export var gun_type: gunType

@export_group("Camera Influence")
@export var shake_intensity: float

@export_group("Post-Firing FX")
@export var recoil: float
@export var player_knockback: float

@export_group("Weapon Sprites")
@export var gun_texture: Texture2D
@export var muzzle_flash_animation: SpriteFrames
@export var shell_texture: Texture2D

enum gunType{
	AUTO = 0,
	SEMIAUTO = 1,
	LASER = 2,
	CHARGE = 3
}
