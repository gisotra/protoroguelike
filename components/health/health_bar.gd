extends ProgressBar
class_name HealthBar

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var health: HealthComponent = $".."

var show: bool = false
"""
por default ela é transparente

ao tomar dano, ela fica visível (usar lerp) 

timer reseta toda vez que toma dano 

deu 6 segundos que não tomou dano? volta a ficar transparente

se o player (menace area) se aproxima, volta a ficar visível
"""

func _process(delta: float) -> void:
	if show:
		if modulate.a <= 1.0:
			modulate.a = lerp(modulate.a, 1.0, delta * 10)
		
	else: #não devo mostrar
		if modulate.a > 0.0:
			modulate.a = lerp(modulate.a, 0.0, delta * 10)
	pass
	
func _ready() -> void:
	setup_bar()
	
func setup_bar():
	max_value = health.maxHealth
	value = health.maxHealth
	progress_bar.max_value = max_value
	progress_bar.value = value

func change_health_value(current_health_value: float):
	if value == current_health_value:
		pass
	progress_bar.value = current_health_value


func _on_health_component_on_take_damage(health_value) -> void:
	change_health_value(health_value)
