extends Area2D

@export var numero: int = 0
@export var imagem: Texture2D  

func _ready():
	atualizar_label()

func _on_body_entered(body: Node):
	if body.is_in_group("boat"):
		body.coletar_peixe(numero, imagem) 
		queue_free()

func atualizar_label():
	$Label.text = str(numero)
	$Label.position = Vector2(0, -40)
