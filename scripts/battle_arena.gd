extends Node2D

func _ready():
	print("Batalla iniciada")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		print("Volviendo al menú...")
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
