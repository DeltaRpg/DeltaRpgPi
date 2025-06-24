extends CharacterBody2D

@export var speed: float = 40.0
@export var idle_time_range: Vector2 = Vector2(1.5, 3.0)
@export var move_time_range: Vector2 = Vector2(2.0, 4.0)

var direction = Vector2.ZERO
var is_moving = false
var is_idle = true
var player_near = false


var missao_concluida = false

func _ready():
	randomize()
	visible = true
	# _idle() 


func _process(_delta):
	'''
	if is_moving:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	'''

	if player_near:
		if Input.is_action_just_pressed("ui_accept"):
			dialogo_bem_vindo()


func dialogo_bem_vindo():
	var dialog = get_node("/root/Final/Interface/DialogoFinalR")
	dialog.show_dialog(
		"Jovem aprendiz... você nos deu esperança. 
		A cada problema resolvido, a cada cálculo correto,
		você não paenas ajudou  a Anciã Dóris - 
		você transformou conhecimento em poder.
		Em nome de todo o Piauí, e de todos 
		que acreditam na educação,
		meus parabéns. Você provou que 
		matemática pode, sim, ser uma jornada."
	)

	await get_tree().create_timer(5.0).timeout
	dialog.hide_dialog()



func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.name == "Masc" or body.name == "Fem":
		player_near = true


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.name == "Masc" or body.name == "Fem":
		player_near = false
