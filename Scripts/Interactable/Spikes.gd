extends Node2D


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(2)
#damage taken when touching the spike
