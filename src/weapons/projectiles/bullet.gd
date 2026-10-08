extends Area2D
class_name Bullet

var damage = 10
var speed = 1000
var lifetime = 5.0
var source: CharacterBody2D
var attack_data: AttackData:
	set(data):
		attack_data = data
		damage = data.damage
		speed = data.speed
		lifetime = data.lifetime

@export var hitbox_shape: Shape2D

func _ready():
	# $CollisionShape2D.disabled = false
	pass


func _physics_process(_delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * _delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(_enemy: Enemy) -> void:
	var hitbox = Hitbox.new(damage, 0.1, hitbox_shape, source)
	hitbox.position = global_position
	get_tree().root.call_deferred("add_child", hitbox)
	queue_free()
