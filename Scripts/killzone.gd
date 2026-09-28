extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Ow!")
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		if body.has_method("die"):
			body.die()
		timer.start()
	
func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
