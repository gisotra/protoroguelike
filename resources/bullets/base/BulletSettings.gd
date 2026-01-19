extends Resource
class_name BulletSettings 

@export_group("General Configurations")
@export var nome: String
@export var SPEED: int
@export var bullet_duration: float

@export_group("Bullet Sprites")
@export var texture: Texture2D
@export var impact_animation: SpriteFrames

"""enum bulletTypes {
	FIRE,
	ICE, 
	GRASS,
	THUNDER
}"""
