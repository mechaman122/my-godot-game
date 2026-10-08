extends Resource
class_name WeaponData

@export var bullet: PackedScene = preload("res://src/weapons/projectiles/bullet.tscn")
@export var bullet_count: int = 1
@export_range(0, 360) var arc: float = 0
@export_range(0, 20) var fire_rate: float = 2.0

@export var attack_data: AttackData