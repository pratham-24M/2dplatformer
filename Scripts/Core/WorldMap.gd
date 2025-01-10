extends Node2D

@onready var level_holder = $LevelHolder
@onready var player = $Player

var levels = []
@onready var curr_level = $LevelHolder/Level1

var lerp_speed = 0.5
var lerp_progress = 0.0
var completed_movement = true
var lerp_threshold = 0.1

func _ready():
	#SaveManager.load_game()
	player.get_node("AnimationPlayer").play("Idle")
	levels = level_holder.get_children()
	update_levels()
	
	var coins : int
	#for level in SaveManager.save_data.level_dic:
		#coins += SaveManager.save_data.level_dic[level]["coins"]
		#print(coins)

func update_levels():
	for level in levels:
		if level.name in LevelData.level_dic:
			if LevelData.level_dic[level.name]["unlocked"] == true:
				level.get_node("Sprite2D").texture = load("res://Imports/Sprites/EpisodeFifteen/unlocked.png")
				if LevelData.level_dic[level.name]["beaten"] == true:
					level.get_node("Sprite2D").texture = load("res://Imports/Sprites/EpisodeFifteen/beaten.png")
			else:
				level.get_node("Sprite2D").texture = load("res://Imports/Sprites/EpisodeFifteen/locked.png")

func _process(delta):
	var target_level : Node2D
	
	if Input.is_action_pressed("up"):
		if curr_level.up:
			target_level = curr_level.up
	if Input.is_action_pressed("down"):
		if curr_level.down:
			target_level = curr_level.down
	if Input.is_action_pressed("left"):
		if curr_level.left:
			target_level = curr_level.left
	if Input.is_action_pressed("right"):
		if curr_level.right:
			target_level = curr_level.right
	
	if Input.is_action_just_pressed("jump"):
		player.get_node("AnimationPlayer").play("Select")
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://Scenes/WorldScenes/" + curr_level.name + ".tscn")
	
	if target_level and target_level.name in LevelData.level_dic and LevelData.level_dic[target_level.name]["unlocked"] and completed_movement:
		completed_movement = false
		player.get_node("AnimationPlayer").play("Run")
		lerp_progress = 0.0
		while lerp_progress < 1.0:
			lerp_progress += lerp_speed + delta
			lerp_progress = clamp(lerp_progress, 0.0, 1.0)
			player.position = player.position.lerp(target_level.global_position, lerp_progress)
			
			if player.position.distance_to(target_level.global_position) < lerp_threshold:
				break
			
			await get_tree().create_timer(delta).timeout
		player.position = target_level.global_position
		#show_stats(target_level)
		curr_level = target_level
		player.get_node("AnimationPlayer").play("Idle")
		completed_movement = true

func show_stats(target_level):
	if LevelData.level_dic[target_level.name]["unlocked"]:
		target_level.get_node("StatDisplay").visible = true
		target_level.get_node("StatDisplay").get_node("AnimationPlayer").play("Show")
	curr_level.get_node("StatDisplay").get_node("AnimationPlayer").play("Show", 0, -1.0, true)
	
	if LevelData.level_dic[target_level.name]["coins"] == LevelData.level_dic[target_level.name]["max_coins"] and LevelData.level_dic[target_level.name]["score"] > 0:
		target_level.get_node("StatDisplay").get_node("CoinSprite").visible = true
	else:
		target_level.get_node("StatDisplay").get_node("CoinSprite").visible = false
	
	if LevelData.level_dic[target_level.name]["enemies_beaten"] == LevelData.level_dic[target_level.name]["max_enemies_beaten"] and LevelData.level_dic[target_level.name]["score"] > 0:
		target_level.get_node("StatDisplay").get_node("SkullSprite").visible = true
	else:
		target_level.get_node("StatDisplay").get_node("SkullSprite").visible = false
	
	if LevelData.level_dic[target_level.name]["damage_taken"] == 0 and LevelData.level_dic[target_level.name]["score"] > 0:
		target_level.get_node("StatDisplay").get_node("HealthSprite").visible = true
	else:
		target_level.get_node("StatDisplay").get_node("HealthSprite").visible = false



func _on_level_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/WorldScenes/Level5.tscn")


func _on_level_6_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/WorldScenes/Level6.tscn")


func _on_level_7_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/WorldScenes/Level7.tscn")


func _on_level_8_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/WorldScenes/Level8.tscn")


func _on_level_9_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/WorldScenes/Level9.tscn")
#fixes the glitch so now you can play until level 9 when clicked switchs to these 
