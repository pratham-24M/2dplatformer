extends CharacterBody2D
class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var speed = 300.0
@export var jump_velocity = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var attacking = false

var max_health = 4
var health = 0
var can_take_damage = true
@export var hit = false
#data of character

func _ready():
	GameManager.damage_taken = 0
	health = max_health
	GameManager.player = self

func _process(_delta):
	if Input.is_action_just_pressed("attack") && !hit:
		attack()
#when you left click
func _physics_process(delta):
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
		$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
		$AttackArea.scale.x = abs($AttackArea.scale.x)
	# the scale the sword is at when you move left or right
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	#when space is pressed you jump
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	# when space is pressed the players jump and if a or d is press you move left or right.
	update_animation()
	move_and_slide()
	
	if position.y >= 700:
		die()

func attack():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().take_damage(2)
	# the amount of damage you do to whatever you hit for enemies
	attacking = true
	animation.play("Attack")
#plays attack animation
func update_animation():
	if !attacking && !hit:
		if velocity.x != 0:
			animation.play("Run")
		else:
			animation.play("Idle")
		
		if velocity.y < 0:
			animation.play("Jump")
		if velocity.y > 0:
			animation.play("Fall")
# how all the animation gets played.
func take_damage(damage_amount : int):
	if can_take_damage:
		iframes()
		
		hit = true
		attacking = false
		animation.play("Hit")
		#animation when you get hit
		GameManager.damage_taken += 1
		#send signial to gamemanger to show that you have taken damage
		health -= damage_amount
		#your health minus the damage taken
		if health <= 0:
			die()
#if your health = 0 you die 
func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true
#cooldown between taking more damage
func die():
	GameManager.respawn_player()
#sends signial when you die to make you respawn at the spawnpoint checkpoint
func _input(event):
	if event.is_action_pressed("down") && is_on_floor():
		position.y += 5
#to move player in the world map
