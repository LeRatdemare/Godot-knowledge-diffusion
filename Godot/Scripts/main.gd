extends Node3D

@onready var _pause_menu = $PauseMenu
@onready var _world = $Scene1
var game_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	unpause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("pause"):
		if game_paused :
			unpause()
		else :
			pause()

func pause():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_pause_menu.show()
	Engine.time_scale = 0
	game_paused = true

func unpause():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_pause_menu.hide()
	Engine.time_scale = 1
	game_paused = false
