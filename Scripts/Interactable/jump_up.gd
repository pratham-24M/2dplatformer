extends Node2D

@onready var spawn_pos = global_position
#place when it will stay when respawned
func _ready():
	$AnimatedSprite2D.play("idle")
	#plays animation for the whole time
@export var force = -440.40
#how high you will gop when you touch this
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().velocity.y = force
#if players touches this then it will push them the force above

var speed = 200.0
var current_speed = 0.0
#no use for this bc it doesnt move just have it here in case

func _physics_process(delta):
	position.y += current_speed * delta
	
func fall():
	current_speed = speed
	await get_tree().create_timer(5).timeout
	current_speed = 0
#makes it not dissapear when touched
