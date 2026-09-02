extends Control

var selected_map = 0
var selected_character = 0

func _ready():
	print("Menú de selección de mapas cargado")
	# Obtener el personaje seleccionado de la escena anterior
	selected_character = get_parent().get_node("CharacterSelect").selected_character if has_node("../CharacterSelect") else 1
	_create_map_slots()

func _create_map_slots():
	var grid = $GridContainer
	
	# Crear 20 cuadros para mapas
	for i in range(1, 21):
		var map_slot = Panel.new()
		map_slot.custom_minimum_size = Vector2(100, 100)
		map_slot.modulate = Color(0.3, 0.3, 0.35, 1)
		map_slot.name = "Map_%d" % i
		
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
		
		map_slot.add_child(label)
		grid.add_child(map_slot)
		
		# Conectar señales
		map_slot.gui_input.connect(_on_map_slot_clicked.bindv([i]))
		map_slot.mouse_entered.connect(_on_map_slot_hover.bindv([map_slot, true]))
		map_slot.mouse_exited.connect(_on_map_slot_hover.bindv([map_slot, false]))

func _on_map_slot_clicked(event: InputEvent, map_id: int):
	if event is InputEventMouseButton and event.pressed:
		print("Mapa %d seleccionado" % map_id)
		selected_map = map_id
		get_tree().change_scene_to_file("res://scenes/battle_arena.tscn")

func _on_map_slot_hover(slot: Panel, is_hover: bool):
	if is_hover:
		# Efecto hover - más claro
		slot.modulate = Color(0.5, 0.5, 0.55, 1)
	else:
		# Volver al color original
		slot.modulate = Color(0.3, 0.3, 0.35, 1)

func _process(delta):
	# ESC para volver a selección de personaje
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/character_select.tscn")
