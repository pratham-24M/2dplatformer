extends Node2D

func _on_quit_button_pressed():
	get_tree().quit()
#when clicked quits the game

func _on_startgame_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/WorldScenes/world_map.tscn")
#when clicked switchs to worldmap
