extends Control

@onready var fill_max = $ColorRect.size.x
var fill_amount : float
#the collout of it aswell as size

func update_healthbar(health, max_health):
	fill_amount = (float(health) / max_health) * fill_max
	$ColorRect.size.x = fill_amount
#when they take damage it updates with this
