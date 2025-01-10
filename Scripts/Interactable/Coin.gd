extends Node2D
class_name Coin

@export var score = 10
@export var coins = 1
# amount of score you get from it s

func _ready():
	$AnimationPlayer.play("Idle")
#plays animation at the start
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		GameManager.gain_coins(coins)
		GameManager.score += score
		queue_free()
#adds your score when player collects the coin
