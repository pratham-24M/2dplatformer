extends Node2D
#sets constants for falling speed
var speed = 200.0
var current_speed = 0.0

@onready var spawn_pos = global_position
#respawn point of the falling spike
func _physics_process(delta):
	position.y += current_speed * delta

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(2)
#when the falling spike touches the player it takes 2 damage
func _on_player_detect_area_entered(area):
	if area.get_parent() is Player:
		$AnimationPlayer.play("Shake")
#players shakes animation when player is underneath it 
func fall():
	current_speed = speed
	await get_tree().create_timer(4).timeout
	position = spawn_pos
	current_speed = 0
#cooldown for the spikes to respawn
