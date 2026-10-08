extends Area2D
class_name Hitbox

var damage: int = 1
var hitbox_life_time: float
var shape: Shape2D
var source: CharacterBody2D

func _init(_damage: int, _hitbox_life_time: float, _shape: Shape2D, _source: CharacterBody2D) -> void:
    damage = _damage
    hitbox_life_time = _hitbox_life_time
    shape = _shape
    source = _source


func _ready() -> void:
    set_deferred("monitorable", true)
    area_entered.connect(_on_area_entered)

    if hitbox_life_time > 0.0:
        var timer = Timer.new()
        add_child(timer)
        timer.timeout.connect(queue_free)
        timer.call_deferred("start", hitbox_life_time)

    if shape:
        var collision_shape = CollisionShape2D.new()
        collision_shape.shape = shape
        call_deferred("add_child", collision_shape)

    set_collision_layer_value(1, false)
    set_collision_mask_value(1, false)

    # set what hurtbox should this hitbox collide with (player or enemy) below
    # CODE HERE
    if not source:
        return
    if source is Player:
        set_collision_mask_value(4, true)
    elif source is Enemy:
        set_collision_mask_value(3, true)


func _on_area_entered(area: Area2D) -> void:
    if not area.has_method("receive_hit"):
        return
    
    area.receive_hit(damage)