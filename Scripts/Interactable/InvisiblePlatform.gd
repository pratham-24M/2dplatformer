extends StaticBody2D

var showing = false
#visability of the invisible platform when the player touches it

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !showing:
		showing = true
		$AnimationPlayer.play("FadeIn")
#plays animation when the player touches the invisible platform
