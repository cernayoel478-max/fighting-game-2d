extends Control

func _ready():
	print("Menú de selección de personajes cargado")
	_create_character_slots()

func _create_character_slots():
	var grid = $GridContainer
	
	# Crear 20 recuadros para personajes
	for i in range(1, 21):
		var character_slot = Panel.new()
		character_slot.custom_minimum_size = Vector2(100, 100)
		character_slot.modulate = Color(0.3, 0.3, 0.35, 1)
		
		# Crear un label con el número
		var label = Label.new()
		label.text = str(i)
		label.add_theme_font_size_override("font_size", 36)
		label.anchor_left = 0.5
		label.anchor_top = 0.5
		label.anchor_right = 0.5
		label.anchor_bottom = 0.5
		label.offset_left = -20
		label.offset_top = -20
		label.offset_right = 20
		label.offset_bottom = 20
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		character_slot.add_child(label)
		grid.add_child(character_slot)

func _process(delta):
	# ESC para volver al menú
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
