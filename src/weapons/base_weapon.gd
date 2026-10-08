extends Node2D
class_name BaseWeapon

@export var bullet: PackedScene = preload("res://src/weapons/projectiles/bullet.tscn")
@export var bullet_count: int = 1
@export_range(0, 360) var arc: float = 0
@export_range(0, 20) var fire_rate: float = 2.0
@onready var barrel_origin: Node2D = get_node("BarrelOrigin")

@export var weapon_data: WeaponData:
	set(data):
		weapon_data = data
		bullet = data.bullet
		bullet_count = data.bullet_count
		arc = data.arc
		fire_rate = data.fire_rate

var can_shoot: bool = true

func _ready():
	# Initialize weapon properties if needed
	pass


func _process(_delta):
	# Handle weapon logic, such as cooldowns or animations
	pass


func shoot():
	if can_shoot:
		can_shoot = false
		for i in range(bullet_count):
			var new_bullet = bullet.instantiate()
			new_bullet.position = barrel_origin.global_position if barrel_origin else global_position
			new_bullet.attack_data = weapon_data.attack_data
			new_bullet.source = owner as CharacterBody2D

			if bullet_count == 1:
				new_bullet.rotation = global_rotation
			else:
				var arc_rad = deg_to_rad(arc)
				var increment = arc_rad / (bullet_count - 1)
				new_bullet.global_rotation = (
					global_rotation +
					increment * i -
					arc_rad / 2
				)
			
			get_tree().root.call_deferred("add_child", new_bullet)
		await get_tree().create_timer(1.0 / fire_rate).timeout
		can_shoot = true
