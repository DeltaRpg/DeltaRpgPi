extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var scene_to_go = ""


func fade_into(scene):
	scene_to_go = scene
	animation_player.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene_to_file(scene_to_go)
		await get_tree().create_timer(0.1).timeout
		animation_player.play("fade_in")
