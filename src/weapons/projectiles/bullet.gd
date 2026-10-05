extends CharacterBody2D
class_name Bullet

var speed = 1000

func _ready():
	# $CollisionShape2D.disabled = false
	pass


func _physics_process(_delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * _delta


func _on_timer_timeout() -> void:
	queue_free()
