extends Node2D

@onready var player1_spawn = $Player1Spawn
@onready var player2_spawn = $Player2Spawn
@onready var player1_health_bar = $UI/HBoxContainer/Player1Health
@onready var player2_health_bar = $UI/HBoxContainer/Player2Health

var player1: CharacterBody2D
var player2: CharacterBody2D

func _ready() -> void:
	# Instanciar personajes (reemplazar con escenas reales)
	# player1 = load("res://scenes/character.tscn").instantiate()
	# player1.position = player1_spawn.position
	# add_child(player1)
	
	# player2 = load("res://scenes/character.tscn").instantiate()
	# player2.position = player2_spawn.position
	# add_child(player2)
	
	pass

func _process(_delta: float) -> void:
	if player1 and player2:
		# Actualizar barras de salud
		player1_health_bar.value = player1.get_health_percent() * 100
		player2_health_bar.value = player2.get_health_percent() * 100
		
		# Verificar victoria
		if player1.current_health <= 0:
			end_battle("Jugador 2 gana!")
		elif player2.current_health <= 0:
			end_battle("Jugador 1 gana!")

func end_battle(winner: String) -> void:
	print(winner)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
