extends Node2D

@onready var player1_health_bar = $UI/HBoxContainer/Player1Health
@onready var player2_health_bar = $UI/HBoxContainer/Player2Health

func _ready() -> void:
	print("Arena de batalla lista!")

func _process(_delta: float) -> void:
	# Volver al menú con ESC
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
