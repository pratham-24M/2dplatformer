extends Node2D
class_name Checkpoint

@export var spawnpoint = false
@export var win_condition = false

var activated = false


func _ready():
	if spawnpoint:
		activate()
#shows witch one is the spawnpoint of the game
func activate():
	if win_condition:
		GameManager.win()
	#shows witch one is the final checkpoint
	GameManager.current_checkpoint = self
	activated = true
	$AnimationPlayer.play("Activated")
#when player comes into collisionshape it plays activated animation
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !activated:
		activate()
#send signial to show that the player has enter collisonshape
