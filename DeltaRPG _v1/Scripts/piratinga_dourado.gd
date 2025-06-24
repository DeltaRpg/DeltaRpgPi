extends Area2D

@export var numero: int = 99

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("boat"):
		#body.coletar_peixe(numero)
		queue_free()
	
