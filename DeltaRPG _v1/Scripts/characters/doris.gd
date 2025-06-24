extends CharacterBody2D

@export var speed: float = 40.0
@export var idle_time_range: Vector2 = Vector2(1.5, 3.0)
@export var move_time_range: Vector2 = Vector2(2.0, 4.0)

var is_talking = false
var is_moving = false
var player_near = false  # 🚩 Variável para detectar se o player está perto

var dir = Vector2.ZERO
var timer = 0.0

func _ready():
	randomize()
	_on_timer_timeout() # Inicia o ciclo
	#_set_new_state()

func _physics_process(delta):
	# Se o player estiver perto ou estiver falando, não anda
	if is_talking or player_near:
		velocity = Vector2.ZERO
	else:
		if is_moving:
			velocity = dir * speed
		else:
			velocity = Vector2.ZERO

		timer -= delta
		if timer <= 0:
			_set_new_state()

	move_and_slide()
	
	if Input.is_action_just_pressed("chat"):
		print("Chatting with npc")
		$Dialogue.start()
		is_moving = false
		is_talking = false
		$Anim.play("idle")
	
	_play_animation()

func _set_new_state():
	is_moving = not is_moving
	if is_moving:
		dir = _random_direction()
		timer = randf_range(move_time_range.x, move_time_range.y)
	else:
		dir = Vector2.ZERO
		timer = randf_range(idle_time_range.x, idle_time_range.y)

func _random_direction():
	var directions = [
		Vector2(1, 0),
		Vector2(-1, 0),
		Vector2(0, -1),
		Vector2(0, 1),
		Vector2(1, -1).normalized(),
		Vector2(-1, -1).normalized(),
		Vector2(1, 1).normalized(),
		Vector2(-1, 1).normalized()
	]
	return directions.pick_random()

func _play_animation():
	if dir == Vector2.ZERO:
		$Anim.play("idle")
	else:
		if abs(dir.x) > abs(dir.y):
			if dir.x > 0:
				$Anim.play("direita")
			else:
				$Anim.play("esquerda")
		else:
			if dir.y > 0:
				$Anim.play("frente")
			else:
				$Anim.play("costa")


func _on_area_2d_body_entered(body):
	if body.name == "Fem":
		player_near = true

func _on_area_2d_body_exited(body):
	if body.name == "Fem":
		player_near = false


func _on_timer_timeout():
	if is_moving:
		# Troca para parado
		is_moving = false
		dir = Vector2.ZERO
		$Timer.wait_time = randf_range(idle_time_range.x, idle_time_range.y)
	else:
		# Troca para se mover
		is_moving = true
		dir = _random_direction()
		$Timer.wait_time = randf_range(move_time_range.x, move_time_range.y)
	
	$Timer.start()

	
	


func _on_dialogue_dialogue_finished():
	is_talking = false
	player_near = true
	
