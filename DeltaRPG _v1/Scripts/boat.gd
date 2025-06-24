extends CharacterBody2D

var player

@export var speed: float = 200.0
var controlling_player: CharacterBody2D = null
var is_controlled: bool = false

@onready var animation_boat: AnimatedSprite2D = $AnimatedSprite2D

var inventario: Array = []  
var inventario_interface

var peixes_coletados: Array = []  

func _ready():
	add_to_group("boat")
	inventario_interface = get_tree().current_scene.get_node("Inventario")

# -------- MOVIMENTO DO BARCO ---------
func _physics_process(_delta):
	if not is_controlled:
		$Sprite2D.visible = false
		return
	else:
		$Sprite2D.visible = true
		if PersonagemEscolhido.selected_character == "girl":
			$Sprite2D.texture = load("res://delta rpg (assets)/Personagens/Principais/Fem/fem_parda_frente.png")
		else:
			$Sprite2D.texture = load("res://delta rpg (assets)/Personagens/Principais/Masc/masc_parado_frente.png")
		
	var direction: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	velocity = direction * speed
	move_and_slide()
	
	update_animation(direction)


func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		animation_boat.animation = "idle"
	else:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animation_boat.animation = "right"
			else:
				animation_boat.animation = "left"
		else:
			if direction.y > 0:
				animation_boat.animation = "down"
			else:
				animation_boat.animation = "up"
	animation_boat.play()
	

# -------- CONTROLE DO PLAYER ---------
func take_control(player: CharacterBody2D):
	is_controlled = true
	controlling_player = player
	$Camera2D.make_current()

func release_control():
	is_controlled = false
	if controlling_player:
		controlling_player.global_position = global_position + Vector2(0, -50)
		if controlling_player.camera_player:
			controlling_player.camera_player.make_current()



# -------- COLETAR PEIXES ---------
func coletar_peixe(numero: int, imagem: Texture2D):
	inventario.append({"numero": numero, "imagem": imagem})
	
	peixes_coletados.append(numero)
	
	if peixes_coletados.size() >= 7:
		$"../Quest/Control".abrir_com_perguntas(peixes_coletados.duplicate())
		peixes_coletados.clear()


# -------- SISTEMA DE PERGUNTAS ---------
func abrir_pergunta():
	var cena_pergunta = preload("res://Scenes/control.tscn")
	var instancia = cena_pergunta.instantiate()
	instancia.configurar(peixes_coletados)
	
	instancia.connect("pergunta_finalizada", Callable(self, "_quando_pergunta_terminar"))
	
	get_tree().current_scene.add_child(instancia)


func _quando_pergunta_terminar(gabaritou: bool):
	peixes_coletados.clear()
	
	if gabaritou:
		liberar_piratinga_dourado()


func liberar_piratinga_dourado():
	var cena_piratinga = preload("res://Scenes/piratinga_dourado.tscn")
	var instancia = cena_piratinga.instantiate()
	
	instancia.position = Vector2(500, 300)
	
	get_tree().current_scene.add_child(instancia)
