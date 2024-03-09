extends CharacterBody3D
class_name Agent

@onready var _nav = $NavigationAgent3D
@onready var _player = $"../UserBody"
@onready var _pedestal = $"../Pedestal"
const SPEED = 3.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if _pedestal != null:
		if _pedestal.student == self:
			return
		elif _pedestal.student == null and (_pedestal.position - position).length() < 2:
			_pedestal.teach(self)
			return

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	_nav.target_position = _player.position
	var next_path_position = _nav.get_next_path_position()
	var direction = position.direction_to(next_path_position).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
