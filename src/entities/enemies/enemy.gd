extends CharacterBody2D
class_name Enemy

signal died(enemy_instance)

@export_group("Stats")
@export var max_health: int = 100
@export var damage: int = 10

var current_health: int

func _ready():
    current_health = max_health


func _physics_process(delta):
    handle_movement(delta)

func handle_movement(_delta):
    # Implement enemy movement logic here
    # move_and_slide()
    pass

func take_damage(amount: int):
    current_health -= amount
    if current_health <= 0:
        die()


func die():
    died.emit(self)
    queue_free()