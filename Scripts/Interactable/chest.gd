extends Node2D
class_name Chest

@export var score = 55
@export var coins = 55

func _ready():
	$AnimationPlayer.play("onready")
#plays animation
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		$AnimationPlayer.play("Chest")
		await get_tree().create_timer(0.7).timeout
		$AnimationPlayer.play("fade_out")
		await get_tree().create_timer(0.7).timeout
		queue_free()
		GameManager.gain_coins(coins)
		GameManager.score += score
#adds your score when you touch the chest and plays animation
