extends CharacterBody3D
class_name UserBody

@export var acceleration = 8.0
@export var rotation_speed = 12.0
@export var mouse_sensitivity = 0.007

@onready var camera = $Camera3D
@onready var pedestal = $"../Pedestal"

const SPEED = 8.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handle interaction
	if Input.is_action_just_pressed("interact") and pedestal.student != null:
		pedestal.stop_teaching()
	get_move_input(delta)
	
	move_and_slide()

func get_move_input(delta):
	var vy = velocity.y
	velocity.y = 0
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var dir = Vector3(input.x, 0, input.y).rotated(Vector3.UP, rotation.y)
	velocity = lerp(velocity, dir * SPEED, acceleration * delta)
	var vl = velocity * transform.basis
	velocity.y = vy

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
		rotation.y -= event.relative.x * mouse_sensitivity
