extends CharacterBody2D

@export var speed: float = 40.0
@export var idle_time_range: Vector2 = Vector2(1.5, 3.0)
@export var move_time_range: Vector2 = Vector2(2.0, 4.0)

var direction = Vector2.ZERO
var is_moving = false
var is_idle = true
var player_near = false

var required_items = ["cocal"]

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

		if Input.is_action_just_pressed("drop"):
			dialogo_verificar_itens()


func dialogo_bem_vindo():
	var dialog = get_node("/root/Fase1/Interface/macyDialoago") 

	if missao_concluida:
		dialog.show_dialog("✅ Obrigado novamente! Você já concluiu essa missão!")
	else:
		dialog.show_dialog(
			"Fui chamada de salvadora... e de ruína. Lutei 
			contra impérios, fiz pactos que custaram minha alma.
			Venci batalhas que não deveriam ter sido possíveis.
			Mas toda vitória cobra seu preço.
			E agora, o Vazio desperta de novo...
			e eu não posso enfrentá-lo outra vez.
			Este é o último selo.
			Uma prova de mente, não de espada.
			w dPegue o cocal resolvendo o desafio."
		)

	await get_tree().create_timer(5.0).timeout
	dialog.hide_dialog()


func dialogo_verificar_itens():
	var dialog = get_node("/root/Fase1/Quest/MissaoDialogo") 

	if missao_concluida:
		dialog.show_dialog("✅ Você já concluiu essa missão. Muito obrigado novamente!")
	else:
		if Global.check_mission_complete(required_items):
			dialog.show_dialog("✅ Missão concluída!")
			Global.clear_mission_inventory()
			missao_concluida = true 
			Transition.fade_into("res://Scenes/Final/final.tscn")

		else:
			var texto = "❌ Você ainda precisa de:\n"
			for item in required_items:
				if item not in Global.mission_inventory:
					texto += "- " + item + "\n"

			dialog.show_dialog(texto)

	await get_tree().create_timer(4.0).timeout
	dialog.hide_dialog()

func _on_interaction_area_area_entered(area: Area2D) -> void:
	if area.name == "BoatArea":
		player_near = true

func _on_interaction_area_area_exited(area: Area2D) -> void:
	if area.name == "BoatArea":
		player_near = false
