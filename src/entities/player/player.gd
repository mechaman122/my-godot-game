extends CharacterBody2D

@export var speed = 300
@export var bullet_scene: PackedScene = preload("res://src/weapons/projectiles/bullet.tscn")

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

	# shooting
	if Input.is_action_pressed("attack"):
		shoot()


func _physics_process(_delta):
	get_input()
	move_and_slide()


func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	bullet.rotation = global_position.angle_to_point(get_global_mouse_position())
	get_parent().add_child(bullet)