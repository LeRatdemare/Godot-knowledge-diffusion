extends Node3D
class_name Moving_Platform

@onready var animation_player = $AnimationPlayer

func _ready():
	print("Ready !")
	animation_player.play("up_down")
