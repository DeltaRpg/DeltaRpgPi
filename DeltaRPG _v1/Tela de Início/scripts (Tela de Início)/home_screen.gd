extends Control


func _ready():
	MusicPlayerMenuInicial.get_node("AudioStreamPlayer2D").play()
	$Principal/Botoes/sair.disabled = false
	$Principal/Botoes/config.disabled = false
	$Principal/Botoes/play.disabled = false

func _on_play_pressed() -> void:
	Transition.fade_into("res://Tela de Início/Escolher Personagem/escolher_personagem.tscn")
	$Principal/Botoes/sair.disabled = false
	$Principal/Botoes/config.disabled = false
	$Principal/Botoes/play.disabled = true
	pass


func _on_config_pressed() -> void:
	$Principal/Botoes/play.disabled = false
	$Principal/Botoes/sair.disabled = false
	$Principal/Botoes/config.disabled = true
	pass # Replace with function body.



func _on_sair_pressed() -> void:
	$Principal/Botoes/play.disabled = false
	$Principal/Botoes/config.disabled = false
	$Principal/Botoes/sair.disabled = true
	get_tree().quit()
	pass # Replace with function body.


func _on_play_mouse_entered() -> void:
	$Principal/Botoes/play.modulate = Color(0.7, 0.7, 0.7)
	pass # Replace with function body.


func _on_play_mouse_exited() -> void:
	$Principal/Botoes/play.modulate = Color(1, 1, 1)
	pass # Replace with function body.


func _on_config_mouse_entered() -> void:
	$Principal/Botoes/config.modulate = Color(0.7, 0.7, 0.7)
	pass # Replace with function body.


func _on_config_mouse_exited() -> void:
	$Principal/Botoes/config.modulate = Color(1, 1, 1)
	pass # Replace with function body.


func _on_sair_mouse_entered() -> void:
	$Principal/Botoes/sair.modulate = Color(0.7, 0.7, 0.7)
	pass # Replace with function body.


func _on_sair_mouse_exited() -> void:
	$Principal/Botoes/sair.modulate = Color(1, 1, 1)
	pass # Replace with function body.
