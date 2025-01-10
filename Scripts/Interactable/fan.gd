extends Node2D

@export var force = -550.50
#the amount of force you go up when the player touches this
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().velocity.y = force
#sends signial when the player touches the collisionshape to make it jump



func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().take_damage(1)
