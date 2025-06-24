extends Area2D

@export var item_name: String = "barril_peixe" 

var player_near = false

func _ready():	
	$"../Quest/Enem_quest/Panel".hide()

	var quest = $"../Quest/Enem_quest"
	quest.connect("resposta_certa", Callable(self, "_on_resposta_certa"))

func _on_resposta_certa():
	Global.add_item(item_name)  
	$"../Quest/Enem_quest/Panel".hide()  
	hide()
	queue_free()

func _on_body_entered(body):
	if body.name == "Masc" or body.name == "Fem":
		player_near = true

func _on_body_exited(body):
	if body.name == "Masc" or body.name == "Fem":
		player_near = false
		$"../Quest/Enem_quest/Panel".hide()

func _process(_delta):
	if player_near and Input.is_action_just_pressed("ui_accept"):
		var panel = $"../Quest/Enem_quest/Panel"
		panel.visible = not panel.visible
