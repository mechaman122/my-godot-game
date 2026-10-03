extends CharacterBody2D
class_name Bullet

var speed = 500

func _ready():
    $CollisionShape2D.disabled = false


func _physics_process(_delta):
    position += Vector2.RIGHT.rotated(rotation) * speed * _delta