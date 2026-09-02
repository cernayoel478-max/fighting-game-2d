extends Control

func _ready():
	print("Menú cargado")

func _on_play_pressed():
	print("Entrando a batalla...")
	get_tree().change_scene_to_file("res://scenes/battle_arena.tscn")

func _on_quit_pressed():
	print("Saliendo...")
	get_tree().quit()
