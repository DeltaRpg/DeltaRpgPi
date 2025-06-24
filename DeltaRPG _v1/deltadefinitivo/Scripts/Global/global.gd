extends Node

var mission_inventory: Array = []

func add_item(item_name: String) -> void:
	if item_name not in mission_inventory:
		mission_inventory.append(item_name)
		print("Item adicionado:", item_name)
	else:
		print("Você já tem", item_name)

func check_mission_complete(required_items: Array) -> bool:
	for item in required_items:
		if item not in mission_inventory:
			return false
	return true

func clear_mission_inventory() -> void:
	mission_inventory.clear()
	print("Inventário limpo")
