extends Resource
class_name BulletSettings 

@export var nome: String
@export var SPEED: int
@export var bulletType: bulletTypes
@export var texture: Texture2D
@export var bullet_duration: float

enum bulletTypes {
	FIRE,
	ICE, 
	GRASS,
	THUNDER
}
