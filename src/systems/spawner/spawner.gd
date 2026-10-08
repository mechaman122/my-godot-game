extends Node2D

@export var player: Player
@export var enemy: PackedScene

var distance: float = 400.0

var minute: int:
	set(value):
		minute = value
		%Minute.text = str(value).lpad(2,'0')

var second: int:
	set(value):
		second = value
		if second >= 60:
			second = 0
			minute += 1
		%Second.text = str(value).lpad(2,'0')


func spawn(pos: Vector2) -> void:
	var enemy_instance = enemy.instantiate()

	enemy_instance.position = pos
	enemy_instance.player_ref = player
	get_tree().current_scene.add_child(enemy_instance)


func get_random_pos() -> Vector2:
	var angle = randf() * TAU
	var offset = Vector2(cos(angle), sin(angle)) * distance
	return player.global_position + offset


func spawn_multiple(count: int = 1) -> void:
	for i in range(count):
		spawn(get_random_pos())
		
		
func _on_timer_timeout() -> void:
	second += 1
	spawn_multiple(second % 5 + 1)  # Spawn more enemies as time progresses
