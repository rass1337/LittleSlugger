extends Area2D

@onready var game_manager: Node = %GameManager


func _on_body_entered(body):
	if body.is_in_group("player"):
		game_manager.add_point()
		if body.has_method("eat"):
			body.eat()
		queue_free()
