extends PointLight2D

@export var player: Node2D
const follow_speed = 6.0
@export var noise: FastNoiseLite
var time_passed := 0.0
@export var drift_amount: float = 40.0
@export var drift_speed: float = 0.4


func _process(delta):
	time_passed += delta
	var sampled_noise = noise.get_noise_1d(time_passed * 1.5)
	sampled_noise = abs(sampled_noise)
	energy = 0.2 + sampled_noise * 1.6

func _physics_process(delta):
	var weight = 1 - exp(-follow_speed * delta)
	var drift = Vector2(
		sin(time_passed * drift_speed) * drift_amount,
		sin(time_passed * drift_speed * 0.7 + 1.0) * drift_amount * 0.5
	)
	global_position = global_position.lerp(player.global_position + drift, weight)
