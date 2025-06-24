extends Control

func _ready() -> void:
	$Panel.visible = false

func show_dialog(texto: String):
	$Panel.visible = true
	$Panel/NinePatchRect/Label.text = texto
	visible = true
	
func hide_dialog():
	visible = false
