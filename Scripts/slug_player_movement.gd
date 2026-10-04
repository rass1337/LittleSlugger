extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var max_speed: float = 1000.0
@export var accel: float = 3.0
@export var turn_speed: float = 5.0
@export var stop_rotate: float = 25
var dead : bool = false
var eating : bool = false
var controllable = true #cutscene

func die():
		dead = true
func eat():
		eating = true
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "eat":
		eating = false


 #move the slug towards cursor
func _physics_process(delta: float) -> void:
	var to_mouse = get_global_mouse_position() - global_position
	var target_vel = to_mouse.limit_length(max_speed)
	velocity = velocity.lerp(target_vel, 1.0 - exp(-accel * delta)) 
	move_and_slide()
	
	#not controllable during "cutscenes"
	if not controllable: 
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
# rotates the slug towards the cursor and stops rotation when it reaches the cursor, it was tweaking otherwise
	if to_mouse.length() > stop_rotate :
		rotation = lerp_angle(rotation, to_mouse.angle() + deg_to_rad(90), 1.0 - exp(-turn_speed * delta))
	
#swaps between idle and move animation, speeds up the animation play speed depending on distance from cursor
	if eating:
		animated_sprite.play("eat")
		return
	if dead:
		animated_sprite.play("damage")
		return
	if velocity.length() > 200.0:
		animated_sprite.play("move")
		var howfast = clamp(velocity.length() / max_speed, 0.0, 1.0) 
		animated_sprite.speed_scale = lerp(1.0, 3.0, howfast)
	else:
		animated_sprite.play("idle")
