extends Area2D

@onready var player = get_parent().get_node("Player")  # Find Player
@onready var talk_area = $Area2D  # The Area2D (interaction zone)
@export var dialogue_box: CanvasLayer  # Dialogue UI
@export var dialogue_text: String = "Hello, traveler! Welcome to our world."

func _ready():
	# Connect the "body_entered" signal to detect when the player is near
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body == player:
		# When the player enters the area, show the dialogue
		dialogue_box.visible = true
		dialogue_box.get_node("DialogueLabel").text = dialogue_text

func _on_body_exited(body):
	if body == player:
		# When the player leaves, hide the dialogue
		dialogue_box.visible = false
