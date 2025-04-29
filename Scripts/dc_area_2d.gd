extends Area2D

var player: CharacterBody2D
var dialogue_box: CanvasLayer

func _ready():
	player = get_parent().get_node("Player")  # Find the player node
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	dialogue_box = get_parent().get_node("Doctor diago")
	if body == player:
		dialogue_box.visible = false # Show the dialogue
