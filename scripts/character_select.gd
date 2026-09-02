extends Control

var selected_character = 0
var character_stats = {}

func _ready():
	print("Menú de selección de personajes cargado")
	_initialize_character_stats()
	_create_character_slots()
	_create_stats_panel()

func _initialize_character_stats():
	# Inicializar stats para los 20 personajes con total de 250 puntos
	# Diferentes distribuciones para cada personaje
	var stat_distributions = [
		{"vida": 80, "daño": 60, "defensa": 60, "velocidad": 50},    # 1
		{"vida": 75, "daño": 65, "defensa": 55, "velocidad": 55},    # 2
		{"vida": 70, "daño": 70, "defensa": 50, "velocidad": 60},    # 3
		{"vida": 85, "daño": 55, "defensa": 65, "velocidad": 45},    # 4
		{"vida": 90, "daño": 50, "defensa": 70, "velocidad": 40},    # 5
		{"vida": 65, "daño": 75, "defensa": 55, "velocidad": 55},    # 6
		{"vida": 60, "daño": 80, "defensa": 50, "velocidad": 60},    # 7
		{"vida": 70, "daño": 65, "defensa": 60, "velocidad": 55},    # 8
		{"vida": 95, "daño": 45, "defensa": 75, "velocidad": 35},    # 9
		{"vida": 55, "daño": 85, "defensa": 45, "velocidad": 65},    # 10
		{"vida": 75, "daño": 70, "defensa": 55, "velocidad": 50},    # 11
		{"vida": 80, "daño": 55, "defensa": 70, "velocidad": 45},    # 12
		{"vida": 65, "daño": 80, "defensa": 50, "velocidad": 55},    # 13
		{"vida": 70, "daño": 60, "defensa": 65, "velocidad": 55},    # 14
		{"vida": 85, "daño": 65, "defensa": 50, "velocidad": 50},    # 15
		{"vida": 60, "daño": 75, "defensa": 60, "velocidad": 55},    # 16
		{"vida": 90, "daño": 55, "defensa": 65, "velocidad": 40},    # 17
		{"vida": 70, "daño": 70, "defensa": 55, "velocidad": 55},    # 18
		{"vida": 75, "daño": 60, "defensa": 70, "velocidad": 45},    # 19
		{"vida": 50, "daño": 90, "defensa": 45, "velocidad": 65},    # 20
	]
	
	for i in range(1, 21):
		var dist = stat_distributions[i - 1]
		character_stats[i] = {
			"vida": dist["vida"],
			"daño": dist["daño"],
			"defensa": dist["defensa"],
			"velocidad": dist["velocidad"],
			"total": 250
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
	vbox.name = "VBoxContainer"
	vbox.anchor_right = 1.0
	vbox.anchor_bottom = 1.0
	vbox.add_theme_constant_override("separation", 15)
	vbox.add_theme_constant_override("margin_left", 10)
	vbox.add_theme_constant_override("margin_right", 10)
	vbox.add_theme_constant_override("margin_top", 10)
	vbox.add_theme_constant_override("margin_bottom", 10)
	
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
		# Label del stat con valor
		var stat_label = Label.new()
		stat_label.name = "Label_%s" % stat
		stat_label.text = stat.to_upper() + ": 0/250"
		stat_label.add_theme_font_size_override("font_size", 12)
		vbox.add_child(stat_label)
		
		# ProgressBar
		var progress = ProgressBar.new()
		progress.name = "ProgressBar_%s" % stat
		progress.custom_minimum_size = Vector2(200, 20)
		progress.min_value = 0
		progress.max_value = 100
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
	if not has_node("StatsPanel"):
		return
	
	var stats_panel = get_node("StatsPanel")
	if not stats_panel.has_node("VBoxContainer"):
		return
	
	var stats = character_stats[character_id]
	var total = stats["total"]
	
	# Actualizar barras de progreso con valores del personaje
	var stat_names = ["vida", "daño", "defensa", "velocidad"]
	
	for stat_name in stat_names:
		var label = stats_panel.get_node_or_null("VBoxContainer/Label_%s" % stat_name)
		var progress = stats_panel.get_node_or_null("VBoxContainer/ProgressBar_%s" % stat_name)
		
		if label:
			var value = stats[stat_name]
			label.text = stat_name.to_upper() + ": %d/%d" % [value, total]
		
		if progress:
			var value = stats[stat_name]
			progress.value = (value / float(total)) * 100

func _process(delta):
	# ESC para volver al menú
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
