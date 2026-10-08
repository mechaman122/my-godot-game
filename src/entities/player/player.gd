extends CharacterBody2D
class_name Player

@export var speed = 300
@export var bullet_scene: PackedScene = preload("res://src/weapons/projectiles/bullet.tscn")
@export var current_weapon: Node2D

func _ready():
	current_weapon = get_node("BaseWeapon")


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

	# weapon handling
	current_weapon.global_rotation = (get_global_mouse_position() - global_position).angle()
	if current_weapon.global_rotation > PI / 2 or current_weapon.global_rotation < -PI / 2:
		current_weapon.scale.y = -1
	else:
		current_weapon.scale.y = 1

	# shooting
	if Input.is_action_pressed("attack"):
		current_weapon.shoot()


func _physics_process(_delta):
	get_input()
	move_and_slide()