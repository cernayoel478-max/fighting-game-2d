extends CharacterBody2D

# Stats del personaje
@export var max_health: int = 100
@export var speed: float = 300.0
@export var jump_force: float = -400.0
@export var attack_damage: int = 10
@export var attack_cooldown: float = 0.5

var current_health: int
var is_attacking: bool = false
var is_jumping: bool = false
var facing_right: bool = true
var attack_timer: float = 0.0
var combo_counter: int = 0

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack_area: Area2D = $AttackArea

func _ready() -> void:
	current_health = max_health
	attack_timer = attack_cooldown

func _physics_process(delta: float) -> void:
	# Gravedad
	velocity.y += get_gravity() * delta
	
	# Entrada
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	
	# Movimiento horizontal
	velocity.x = input_vector.x * speed
	
	# Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force
		is_jumping = true
		play_animation("jump")
	
	# Ataques
	if Input.is_action_just_pressed("attack") and attack_timer >= attack_cooldown:
		perform_attack("punch")
		attack_timer = 0.0
	
	if Input.is_action_just_pressed("special_attack") and attack_timer >= attack_cooldown:
		perform_special_attack()
		attack_timer = 0.0
	
	# Actualizar dirección
	if input_vector.x != 0:
		facing_right = input_vector.x > 0
		sprite.flip_h = not facing_right
	
	# Actualizar temporizador de ataque
	attack_timer += delta
	
	# Aplicar gravedad y movimiento
	move_and_slide()
	
	# Actualizar animaciones
	update_animations()

func perform_attack(attack_type: String) -> void:
	if is_attacking:
		return
	
	is_attacking = true
	combo_counter += 1
	play_animation(attack_type)
	
	# Detectar golpes en el área de ataque
	var bodies = attack_area.get_overlapping_bodies()
	for body in bodies:
		if body != self and body.has_method("take_damage"):
			body.take_damage(attack_damage)

func perform_special_attack() -> void:
	if is_attacking:
		return
	
	is_attacking = true
	combo_counter = 0
	play_animation("special")
	
	# Ataque especial con más daño
	var bodies = attack_area.get_overlapping_bodies()
	for body in bodies:
		if body != self and body.has_method("take_damage"):
			body.take_damage(attack_damage * 2)

func take_damage(damage: int) -> void:
	current_health -= damage
	current_health = max(0, current_health)
	
	if current_health <= 0:
		die()
	else:
		play_animation("hit")

func die() -> void:
	play_animation("death")
	set_physics_process(false)

func play_animation(anim_name: String) -> void:
	if animation_player and animation_player.has_animation(anim_name):
		animation_player.play(anim_name)

func update_animations() -> void:
	if is_on_floor():
		is_jumping = false
		if velocity.x != 0:
			play_animation("run")
		else:
			play_animation("idle")

func reset_attack() -> void:
	is_attacking = false

func get_health_percent() -> float:
	return float(current_health) / float(max_health)
