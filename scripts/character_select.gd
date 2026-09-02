extends Control

var selected_character = 0
var character_stats = {}

func _ready():
	print("Menú de selección de personajes cargado")
	_initialize_character_stats()
	_create_character_slots()
	_create_stats_panel()

func _initialize_character_stats():
	# Inicializar stats para los 20 personajes
	for i in range(1, 21):
		character_stats[i] = {
			"vida": 80 + (i * 3),  # 83-143
			"daño": 50 + (i * 2),  # 52-102
			"defensa": 40 + (i * 2),  # 42-92
			"velocidad": 60 + i  # 61-80
		}

func _create_character_slots():
	var grid = $GridContainer
	
	# Crear 20 recuadros para personajes
	for i in range(1, 21):
		var character_slot = Panel.new()
		character_slot.custom_minimum_size = Vector2(100, 100)
		character_slot.modulate = Color(0.3, 0.3, 0.35, 1)
		character_slot.name = "Character_%d" % i
		
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
		
		# Conectar señales
		character_slot.gui_input.connect(_on_character_slot_clicked.bindv([i]))
		character_slot.mouse_entered.connect(_on_character_slot_hover.bindv([character_slot, true, i]))
		character_slot.mouse_exited.connect(_on_character_slot_hover.bindv([character_slot, false, i]))

func _create_stats_panel():
	var stats_panel = Panel.new()
	stats_panel.name = "StatsPanel"
	stats_panel.anchor_left = 0.65
	stats_panel.anchor_top = 0.15
	stats_panel.anchor_right = 0.95
	stats_panel.anchor_bottom = 0.95
	stats_panel.modulate = Color(0.2, 0.2, 0.25, 1)
	
	# Crear VBox para los stats
	var vbox = VBoxContainer.new()
	vbox.anchor_right = 1.0
	vbox.anchor_bottom = 1.0
	vbox.add_theme_constant_override("separation", 20)
	
	# Título
	var title = Label.new()
	title.text = "STATS"
	title.add_theme_font_size_override("font_size", 24)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(title)
	
	# Stats a mostrar
	var stats = ["vida", "daño", "defensa", "velocidad"]
	var stat_colors = {
		"vida": Color.RED,
		"daño": Color.ORANGE,
		"defensa": Color.BLUE,
		"velocidad": Color.YELLOW
	}
	
	for stat in stats:
		# Label del stat
		var stat_label = Label.new()
		stat_label.text = stat.to_upper()
		stat_label.add_theme_font_size_override("font_size", 14)
		vbox.add_child(stat_label)
		
		# ProgressBar
		var progress = ProgressBar.new()
		progress.name = "ProgressBar_%s" % stat
		progress.custom_minimum_size = Vector2(200, 20)
		progress.value = 50
		progress.modulate = stat_colors[stat]
		vbox.add_child(progress)
	
	stats_panel.add_child(vbox)
	add_child(stats_panel)

func _on_character_slot_clicked(event: InputEvent, character_id: int):
	if event is InputEventMouseButton and event.pressed:
		print("Personaje %d seleccionado" % character_id)
		selected_character = character_id
		get_tree().change_scene_to_file("res://scenes/battle_arena.tscn")

func _on_character_slot_hover(slot: Panel, is_hover: bool, character_id: int):
	if is_hover:
		# Efecto hover - más claro
		slot.modulate = Color(0.5, 0.5, 0.55, 1)
		# Actualizar stats panel
		_update_stats_display(character_id)
	else:
		# Volver al color original
		slot.modulate = Color(0.3, 0.3, 0.35, 1)

func _update_stats_display(character_id: int):
	var stats_panel = get_node("StatsPanel")
	var stats = character_stats[character_id]
	
	# Actualizar barras de progreso
	var progress_vida = stats_panel.get_node("VBoxContainer/ProgressBar_vida")
	var progress_daño = stats_panel.get_node("VBoxContainer/ProgressBar_daño")
	var progress_defensa = stats_panel.get_node("VBoxContainer/ProgressBar_defensa")
	var progress_velocidad = stats_panel.get_node("VBoxContainer/ProgressBar_velocidad")
	
	# Normalizar valores (0-100)
	progress_vida.value = (stats["vida"] / 200.0) * 100
	progress_daño.value = (stats["daño"] / 150.0) * 100
	progress_defensa.value = (stats["defensa"] / 120.0) * 100
	progress_velocidad.value = (stats["velocidad"] / 100.0) * 100

func _process(delta):
	# ESC para volver al menú
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
