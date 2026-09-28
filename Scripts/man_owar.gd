extends CharacterBody2D

@export var speed: float = 110.0
@export var back_home: float = 4.0

var player = null
var home_position: Vector2

func _ready():
	home_position = global_position

func _physics_process(delta: float) -> void:
	var player_position: Vector2 = player.global_position if player else home_position
	var distance_to_player = global_position.distance_to(player_position)

	if distance_to_player > back_home:
		velocity = global_position.direction_to(player_position) * speed
		look_at(player_position)
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func _on_detect_radius_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_detect_radius_body_exited(body):
	if body.is_in_group("player"):
		player = null
