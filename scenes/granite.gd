extends Area2D

@onready var dialogue_box = $DialogueBox
@onready var dialogue_label = $DialogueBox/DialogueLabel
@onready var choice_box = $DialogueBox/ChoiceBox
@onready var yes_button = $DialogueBox/ChoiceBox/YesButton
@onready var no_button = $DialogueBox/ChoiceBox/NoButton
@onready var start_button = $DialogueBox/StartButton
@onready var answer_buttons = $DialogueBox/AnswerButtons
@onready var op_1 = $CanvasLayer/Panel/AnswerButtons/Op1
@onready var op_2 = $CanvasLayer/Panel/AnswerButtons/Op2
@onready var op_3 = $CanvasLayer/Panel/AnswerButtons/Op3
@onready var granite_rock = get_node("/Game/Granite/Sprite2D")
@onready var graph = $Graph
@onready var cograph = $CoGraph

var mission_started = false
var dialogue_text = "Hello, astronaut! You’ve found the spectrometer. Can you collect rock samples and analyze them?"
var current_char_index = 0
var typing_speed = 0.05

var rock_type = "basalt"
var planet_choices = ["Earth", "Mars", "Venus"]
var current_question = 0
var rock_positions = [Vector2(200, 300), Vector2(400, 350), Vector2(600, 280)]

var dialogue_lines = [
	"🧑‍🚀 What type of rock is this?",
]

func _ready():
	dialogue_box.visible = false
	choice_box.visible = false
	start_button.visible = false
	start_button.pressed.connect(_on_start_mission_button_pressed)

	yes_button.pressed.connect(_on_yes_pressed)
	no_button.pressed.connect(_on_no_pressed)

	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

	granite_rock.visible = false
	graph.visible = false
	cograph.visible = false

	start_button.pressed.connect(_on_start_mission_button_pressed)
	
func _on_start_mission_button_pressed():
	print("Mission started!")
	start_button.visible = false;
	mission_started = true
	# Show mission-related elements
	granite_rock.visible = true  # Make the spectrometer rock visible
	graph.visible = true  # Show the graph that would be used during the mission
	cograph.visible = true  # Show another UI element related to the mission

func _on_body_entered(body):
	if body.name == "Player" and not mission_started:
		dialogue_box.visible = true
		start_typing_dialogue()

func _on_body_exited(body):
	if body.name == "Player":
		dialogue_box.visible = false
		choice_box.visible = false
		current_char_index = 0
		dialogue_label.text = ""

func start_typing_dialogue():
	current_char_index = 0
	dialogue_label.text = ""
	await _type_dialogue()

func _type_dialogue():
	while current_char_index < dialogue_text.length():
		dialogue_label.text += dialogue_text[current_char_index]
		current_char_index += 1
		await get_tree().create_timer(typing_speed).timeout
	choice_box.visible = true  # Show Yes/No

func _on_yes_pressed():
	print("Player accepted the mission!")
	choice_box.visible = false
	mission_started = true
	start_button.visible = false
	granite_rock.visible = true
	graph.visible = true
	cograph.visible = true
	dialogue_box.visible = true
	dialogue_label.text = "You've found a rock! What rock is it?"

func _on_no_pressed():
	print("Player declined the mission.")
	choice_box.visible = false

	
