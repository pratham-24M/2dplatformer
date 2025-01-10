extends CharacterBody2D
class_name SabertoothExtrahp

@export var speed = -40.0
var current_speed = 0.0

@export var score = 200

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false
var dead = false

var max_health = 35
var health

var hit = false
var can_attack = true


func _ready():
	health = max_health
	$AnimationPlayer.play("Run")
#plays this animation at the start of the game 
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()
	
	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
#flip enemy
func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead && can_attack:
		area.get_parent().take_damage(3)

func take_damage(damage_amount):
	if !dead:
		$AnimationPlayer.play("Hit")
		
		health -= damage_amount
		
		get_node("Healthbar").update_healthbar(health, max_health)
		
		if health <= 0:
			die()
#when loses all health sends die signial and plays hit animation when taken damage
func get_hit():
	hit = !hit
	
	if hit:
		current_speed = speed
		speed = 0
		can_attack = false
	else:
		speed = current_speed
		can_attack = true
		$AnimationPlayer.play("Run")
#plays run animation cant attack when hit and speed is set to 0
func die():
	GameManager.enemies_beaten += 1
	GameManager.score += score
	dead = true
	speed = 0
	$AnimationPlayer.play("Die")
#plays death animation when it loses all it health aswell as giving more score
