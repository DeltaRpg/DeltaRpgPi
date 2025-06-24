extends CharacterBody2D

@export var speed: float = 150.0
var can_enter_boat := false
var boat_ref: CharacterBody2D = null
var controlling_boat := false
var is_attacking := false
var player_na_agua = false

var camera_player: Camera2D

@onready var animation_player := $Anim

func _ready() -> void:
	camera_player = Camera2D.new()
	camera_player.zoom = Vector2(3, 3) 
	add_child(camera_player)

func _physics_process(_delta):
	if controlling_boat or is_attacking:
		return  

	var direction: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	velocity = direction * speed
	move_and_slide()
	
	if direction.length() > 0:
		animation_player.play("caminhando")
	else:
		animation_player.play("idle")

	# Flip horizontal do sprite
	if direction.x != 0:
		animation_player.flip_h = direction.x < 0

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		if can_enter_boat and boat_ref and not controlling_boat:
			enter_boat()
		elif controlling_boat:
			exit_boat()

func enter_boat():
	controlling_boat = true
	animation_player.hide()
	$CollisionShape2D.disabled = true
	set_physics_process(false)
	set_collision_layer_value(1, false)  # Ajuste conforme sua layer
	set_collision_mask_value(1, false)
	global_position = boat_ref.global_position
	boat_ref.take_control(self)
	player_na_agua = false

func exit_boat():
	controlling_boat = false
	animation_player.show()
	$CollisionShape2D.disabled = false
	set_physics_process(true)
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	boat_ref.release_control()
	boat_ref = null

func _on_interact_area_area_entered(area: Area2D) -> void:
	if area.name == "BoatArea":
		can_enter_boat = true
		boat_ref = area.get_parent()
		
func _on_interact_area_area_exited(area: Area2D) -> void:
	if area.name == "BoatArea" and not controlling_boat:
		can_enter_boat = false
		boat_ref = null
