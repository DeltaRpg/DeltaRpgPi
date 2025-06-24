extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_girl_pressed() -> void:
	PersonagemEscolhido.selected_character = "girl"
	Transition.fade_into("res://Scenes/Fases/fase_1.tscn")
	pass # Replace with function body.


func _on_boy_pressed() -> void:
	PersonagemEscolhido.selected_character = "boy"
	Transition.fade_into("res://Scenes/Fases/fase_1.tscn")
	pass # Replace with function body.


func _on_girl_mouse_entered() -> void:
	$VBoxContainer/HBoxContainer/MarginContainer/Girl.modulate = Color(0.7, 0.7, 0.7)
	pass # Replace with function body.


func _on_girl_mouse_exited() -> void:
	$VBoxContainer/HBoxContainer/MarginContainer/Girl.modulate = Color(1, 1, 1)
	pass # Replace with function body.


func _on_boy_mouse_entered() -> void:
	$VBoxContainer/HBoxContainer/MarginContainer2/Boy.modulate = Color(0.7, 0.7, 0.7)
	pass # Replace with function body.


func _on_boy_mouse_exited() -> void:
	$VBoxContainer/HBoxContainer/MarginContainer2/Boy.modulate = Color(1, 1, 1)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	Transition.fade_into("res://Tela de Início/Menu Principal/home_screen.tscn")
	pass # Replace with function body.
