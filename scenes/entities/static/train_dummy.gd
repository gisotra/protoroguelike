extends Enemy
class_name Dummy

@onready var time_to_heal: Timer = $time_to_heal
@onready var hit_fx: GPUParticles2D = $hit_FX


func _process(delta: float) -> void :
	if health.current_health < health.maxHealth and time_to_heal.is_stopped():
		print("current health: ", health.current_health)
		print("max health: ", health.maxHealth)
		health.heal(0.8)
		

# eu atualizo esse signal com base no que eu quero que aconteça pro inimigo quando ele recebe dano 
func _on_enemy_hurtbox_collided(damage, pos, knockback_vec) -> void:
	hit_fx.rotation = knockback_vec.angle() #consigo o angulo a partir do vetor
	hit_fx.emitting = true
	"""
	em etapas:
	- instancio uma cena de impacto DO OUTRO LADO do acerto 
	- o dano já foi passado então não se preocupe com isso
	- aplico o knockback
	
	"""
	time_to_heal.start(3)
	
func _apply_knockback():
	print("dracula")


#	hit_fx.rotation = knockback_vec.angle() #consigo o angulo a partir do vetor
#	hit_fx.emitting = true
#	time_to_heal.start(3)
	
