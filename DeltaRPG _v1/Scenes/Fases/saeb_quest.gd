extends Control

signal resposta_certa

func check_answer(option):
	if option == "D":
		$Panel/NinePatchRect/Label2.text = "✅ Correto, você coletou o item!"
		await get_tree().create_timer(2.0).timeout
		$Panel.hide()
		emit_signal("resposta_certa")
	else:
		$Panel/NinePatchRect/Label2.text = "❌ Resposta incorreta, tente novamente"

func _on_button_a_pressed() -> void:
	check_answer("A")

func _on_button_b_pressed() -> void:
	check_answer("B")

func _on_button_c_pressed() -> void:
	check_answer("C")

func _on_button_d_pressed() -> void:
	check_answer("D")

func _on_button_e_pressed() -> void:
	check_answer("E")
