extends CharacterBody2D
class_name Enemy

signal died(enemy_instance)

@export_group("Stats")
@export var max_health: int = 50
@export var damage: int = 10
@export var player_ref: Player

var speed: float = 100.0
var current_health: int

func _ready():
	current_health = max_health


func _physics_process(delta):
	handle_movement(delta)


func handle_movement(_delta):
	velocity = (player_ref.global_position - global_position).normalized() * speed
	move_and_collide(velocity * _delta)

func take_damage(amount: int):
	current_health -= amount
	print(current_health)
	if current_health <= 0:
		die()


func die():
	died.emit(self)
	queue_free()
