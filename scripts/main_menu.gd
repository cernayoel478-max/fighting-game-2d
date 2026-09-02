extends Control

func _ready() -> void:
	pass

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/battle_arena.tscn")

func _on_settings_pressed() -> void:
	print("Abriendo configuración...")
	# Implementar menú de configuración

func _on_quit_pressed() -> void:
	get_tree().quit()
