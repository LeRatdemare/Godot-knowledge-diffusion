extends CSGCombiner3D

@onready var respawn_point = $respawn_point
@onready var VFX = $FogVolume
var knowledge_bank = 100
var student = null

# Called when the node enters the scene tree for the first time.
func _ready():
	VFX.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if student:
		student.position = Vector3(position.x, position.y + 2, position.z)

func teach(agent):
	student = agent
	VFX.visible = true

func stop_teaching():
	student.position = respawn_point.global_position + Vector3.UP*1.5
	student = null
	VFX.visible = false
