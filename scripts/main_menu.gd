extends Control

func _ready():
	print("Menú cargado")

func _on_play_pressed():
	print("Entrando a selección de personajes...")
	get_tree().change_scene_to_file("res://scenes/character_select.tscn")

func _on_quit_pressed():
	print("Saliendo...")
	get_tree().quit()
