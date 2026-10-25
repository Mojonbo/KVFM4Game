extends Node

"""
An example scene named "main" which is set in the project settings to load on startup.
Currently, the only function is to add a designated scene on startup.
By "preloading" the scene, this means it is always loaded into memory on project launch.

The only other project setting changed from Godot 4.6 default is to change the renderer to Forward+ for the outline shader.
"""

@export var first_scene := preload("res://01_scene/EXAMPLE_cow.tscn")
# NOTE using a UID here instead of a string path allows the .tscn to be moved without breaking the reference
# However, using a UID has the downside that replacing the scene will require updating the UID in the editor here

func _ready() -> void:
	var new_scene = first_scene.instantiate()
	add_child(new_scene)
