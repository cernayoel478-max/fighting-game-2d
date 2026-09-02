extends Control

func _ready() -> void:
	print("Menú principal cargado")

func _on_play_pressed() -> void:
	print("Botón JUGAR presionado")
	get_tree().change_scene_to_file("res://scenes/battle_arena.tscn")

func _on_settings_pressed() -> void:
	print("Abriendo configuración...")

func _on_quit_pressed() -> void:
	print("Saliendo del juego...")
	get_tree().quit()
