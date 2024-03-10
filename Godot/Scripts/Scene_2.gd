extends Node3D

@export var _agent_template = preload("res://Agents/agent.tscn")
@export var _pedestal_template = preload("res://Scenes/elements/pedestal.tscn")
@export var terrain_size = 15
@export var nb_agents = 25

@onready var _gridmap = $NavigationRegion3D/GridMap
@onready var _navigation = $NavigationRegion3D


##################### BUILT-IN #####################


# Called when the node enters the scene tree for the first time.
func _ready():
	# Set ground
	for x in range(-terrain_size, terrain_size):
		for z in range(-terrain_size, terrain_size):
			_gridmap.set_cell_item(Vector3(x, 0, z), 0)
	# Set map borders 
	for y in range(10):
		for x in range(-terrain_size, terrain_size):
			for z in range(-terrain_size, terrain_size):
				if (x==-terrain_size or x==terrain_size-1 or z==-terrain_size or z==terrain_size-1):
					_gridmap.set_cell_item(Vector3(x, y, z), 2)
	_navigation.bake_navigation_mesh()
	# Spawn Agents after navigation is baked
	
	# Spawn pedestals
	var pedestal = _pedestal_template.instantiate()
	pedestal.position = Vector3(10, 1.5, -3)
	$UserBody.pedestal = pedestal
	add_child(pedestal)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


##################### MY FUNCTIONS #####################


func spawn_agents(nb_agents: int):
	for i in range(nb_agents):
		var new_agent = _agent_template.instantiate() as Agent
		var randx = randi_range(-terrain_size+1, terrain_size-1)
		var randz = randi_range(-terrain_size+1, terrain_size-1)
		new_agent.position = Vector3(randx, 3, randz)
		new_agent.scale *= 0.5
		add_child(new_agent)


##################### SIGNALS #####################


func _on_navigation_region_3d_bake_finished():
	spawn_agents(nb_agents)
