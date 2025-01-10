extends StaticBody2D
class_name Canon

var canon_ball = load("res://Scenes/Interactable/canon_ball.tscn")
var debris = load("res://Scenes/Interactable/canon_debris.tscn")

@export var score = 100

@export var shooting : bool
var firerate = 2

@onready var animation_player = $AnimationPlayer
@onready var firepoint = $Firepoint

var max_health = 3
var health

func _ready():
	health = max_health
	shooting = true
	shoot()

func shoot():
	while shooting:
		animation_player.play("Fire")
		await get_tree().create_timer(firerate).timeout
#cooldown between shoots
func fire():
	var spawned_ball = canon_ball.instantiate()
	spawned_ball.direction = firepoint.scale.x
	spawned_ball.global_position = firepoint.position
	add_child(spawned_ball)
#canon ball plays at the canon
func take_damage(damage_amount):
	health -= damage_amount
	
	get_node("Healthbar").update_healthbar(health, max_health)
	
	animation_player.play("Hit")
	#play animation 
	if health <= 0:
		die()
#when hit till its health is equal to 0 it dies
func die():
	GameManager.enemies_beaten += 1
	GameManager.score += score
	var spawned_debris = debris.instantiate()
	spawned_debris.global_position = position
	spawned_debris.scale.x = scale.x
	spawned_debris.get_child(1).play("Crumble")
	get_tree().get_root().get_child(1).add_child(spawned_debris)
	queue_free()
#when it does it crumbles
