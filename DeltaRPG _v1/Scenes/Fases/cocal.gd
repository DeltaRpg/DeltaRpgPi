extends Area2D

@export var item_name: String = "cocal" 

var player_near = false

func _ready():
	$"../Quest/DesafioFinal_quest/Panel".hide()
	var quest = $"../Quest/DesafioFinal_quest"
	quest.connect("resposta_certa", Callable(self, "_on_resposta_certa"))

func _on_resposta_certa():
	Global.add_item(item_name)  
	$"../Quest/DesafioFinal_quest/Panel".hide()  
	hide()
	queue_free()
	
func _process(_delta: float) -> void:
	if player_near and Input.is_action_just_pressed("ui_accept"):
		var panel = $"../Quest/DesafioFinal_quest/Panel"
		panel.visible = not panel.visible


func _on_area_entered(area: Area2D) -> void:
	if area.name == "BoatArea":
		player_near = true
		$"../Quest/DesafioFinal_quest/Panel".hide()


func _on_area_exited(area: Area2D) -> void:
	if area.name == "BoatArea":
		player_near = false
		$"../Quest/DesafioFinal_quest/Panel".hide()
