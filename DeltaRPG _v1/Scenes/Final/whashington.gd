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
	var dialog = get_node("/root/Final/Interface/DialogoFinalW")
	dialog.show_dialog(
		"Você ajudou a Macyrajara a resolver o problema final. 
		Tudo isso com raciocínio, corageme e foco. 
		Mas saiba... o verdadeiro desafio ainda está por vir.
		Muito em breve uma nova jornada será revelada, 
		com novos mistérios a desvendar.
		Enquanto isso, celebre sua conquista. 
		E inspire outros a caminhar também pelo Delta do Saber."
	)

	await get_tree().create_timer(5.0).timeout
	dialog.hide_dialog()
	await get_tree().create_timer(4.0).timeout
	dialog.hide_dialog()
	



func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.name == "Masc" or body.name == "Fem":
		player_near = true


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.name == "Masc" or body.name == "Fem":
		player_near = false
		Transition.fade_into("res://Scenes/Final/recompensa.tscn")
