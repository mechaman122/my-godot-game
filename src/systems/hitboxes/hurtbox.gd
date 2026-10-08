extends Area2D
class_name Hurtbox

# maybe add a variable to determine owner stats here
@onready var owner_node = owner

func _ready() -> void:
    monitoring = true

    set_collision_layer_value(1, false)
    set_collision_mask_value(1, false)

    # set what hitbox should this hurtbox collide with (player or enemy) below
    # CODE HERE
    if owner_node is Player:
        set_collision_layer_value(3, true)
    elif owner_node is Enemy:
        set_collision_layer_value(4, true)


func receive_hit(damage: int) -> void:
    owner_node.take_damage(damage)