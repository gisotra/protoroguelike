extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")

const base_text = "[E] to "

var active_areas = [] 
var can_interact = true

func register_area(area: InteractionComponent):
	active_areas.push_back(area)

func unregister_area(area: InteractionComponent):
	var index = active_areas.find(area)
	if index != -1: #não tem nenhuma ocorrência
		active_areas.remove_at(index)

func _process(delta: float) -> void:
	if active_areas.size() > 0 and can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)

func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size () > 0: #existir elementos na minha lista
			can_interact = false
			await active_areas[0].interact.call() #chamo o método daquela minha interação
			can_interact = true
		
func _sort_by_distance_to_player(area1, area2): #algoritmo de sorte customizado
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
	
