extends Node2D

var player

func _ready() -> void:
	if PersonagemEscolhido.selected_character == "girl":
		player = load("res://Scenes/Character/fem.tscn").instantiate()
	else:
		player = load("res://Scenes/Character/masc.tscn").instantiate()
	add_child(player)
	player.position = $SpawnPoint.position
	$Camera2D.make_current()


func _process(_delta: float) -> void:
	$Camera2D.position = player.position.lerp(player.position, 0.1)
	pass
	
