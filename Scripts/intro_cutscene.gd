extends CanvasLayer

static var intro_played = false   

@export var player: Node
@export var imgs: Array[Texture2D]   
@onready var img: TextureRect = $img

var nr = -1

func _ready() -> void:
	if intro_played or imgs.is_empty():
		queue_free()
		return
	intro_played = true
	player.controllable = false
	_next_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") \
	or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		get_viewport().set_input_as_handled()
		_next_slide()

func _next_slide() -> void:
	nr += 1
	if nr >= imgs.size():
		player.controllable = true
		queue_free()
		return
	img.texture = imgs[nr]
	img.show()
