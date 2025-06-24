extends Node2D

var peixes_coletados: Array = []

func _ready():
	$UI/Control.connect("pergunta_finalizada", Callable(self, "_on_control_pergunta_finalizada"))

func coletar_peixe(numero: int):
	peixes_coletados.append(numero)
	
	if peixes_coletados.size() >= 7:
		$UI.abrir_com_perguntas(peixes_coletados.duplicate())
		peixes_coletados.clear()


func _on_control_pergunta_finalizada(sucesso: bool) -> void:
	if sucesso:
		spawn_piratinga_dourado()

func spawn_piratinga_dourado() -> void:
	var piratinga_scene = preload("res://Scennes/piratinga_dourado.tscn")
	var piratinga = piratinga_scene.instantiate()
	piratinga.position = Vector2(500, 300)
	add_child(piratinga)
