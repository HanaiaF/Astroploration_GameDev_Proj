extends Area2D

var player: CharacterBody2D

func _ready():
	# Automatically find the player node (named "Player")
	player = get_parent().get_node("Player")
	
	# Connect the signal to detect when something enters the door area
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body == player:
		get_tree().change_scene_to_file("res://scenes/planet.tscn")
