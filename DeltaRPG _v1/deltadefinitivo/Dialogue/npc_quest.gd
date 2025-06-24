extends Control

signal quest_menu_closed

var quest1_active = false
var quest1_completed = false
var stick = 0

func quest1_chat():
	$quest1_ui.visible = true
	

func _on_yes_button_1_pressed() -> void:
	$quest1_ui.visible = false
	quest1_active = true
	stick = 0
	emit_signal("quest_menu_closed")


func _on_no_button_1_pressed() -> void:
	$quest1_ui.visible = false
	quest1_active = false
	emit_signal("quest_menu_closed")
