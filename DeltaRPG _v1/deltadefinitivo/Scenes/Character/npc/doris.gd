extends CharacterBody2D

@export var speed: float = 40.0
@export var idle_time_range: Vector2 = Vector2(1.5, 3.0)
@export var move_time_range: Vector2 = Vector2(2.0, 4.0)

var direction = Vector2.ZERO
var is_moving = false
var is_idle = true
var player_near = false

var required_items = ["galinha", "barril_peixe", "sapo"]

var missao_concluida = false


func _ready():
	randomize()
	# _idle() 


func _process(delta):
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
	var dialog = get_node("/root/Fase1/Quest/MissaoDialogo") 

	if missao_concluida:
		dialog.show_dialog("✅ Obrigado novamente! Você já concluiu essa missão!")
	else:
		dialog.show_dialog(
			"🎉 Seja bem-vindo(a) ao Delta!\n\n" +
			"Precisamos da sua ajuda para coletar:\n" +
			"🪿 Uma galinha\n" +
			"🐟 Um barril de peixes\n" +
			"🐸 E um sapo.\n\n" +
			"Aperte 'G' quando tiver os itens para entregar!"
		)

	await get_tree().create_timer(5.0).timeout
	dialog.hide_dialog()


func dialogo_verificar_itens():
	var dialog = get_node("/root/Fase1/Quest/MissaoDialogo") 

	if missao_concluida:
		dialog.show_dialog("✅ Você já concluiu essa missão. Muito obrigado novamente!")
	else:
		if Global.check_mission_complete(required_items):
			dialog.show_dialog("✅ Missão concluída! Muito obrigado pela sua ajuda!")
			Global.clear_mission_inventory()
			missao_concluida = true 
		else:
			var texto = "❌ Você ainda precisa de:\n"
			for item in required_items:
				if item not in Global.mission_inventory:
					texto += "- " + item + "\n"

			dialog.show_dialog(texto)

	await get_tree().create_timer(4.0).timeout
	dialog.hide_dialog()


func _on_interaction_area_body_entered(body):
	if body.name == "Masc" or body.name == "Fem":
		player_near = true


func _on_interaction_area_body_exited(body):
	if body.name == "Masc" or body.name == "Fem":
		player_near = false
