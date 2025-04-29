extends Area2D

@onready var dialogue_box = $DialogueBox
@onready var dialogue_label = $DialogueBox/DialogueLabel
@onready var choice_box = $DialogueBox/ChoiceBox
@onready var yes_button = $DialogueBox/ChoiceBox/YesButton
@onready var no_button = $DialogueBox/ChoiceBox/NoButton
@onready var start_button = $DialogueBox/StartButton
@onready var RockScene = preload("res://Rock.tscn")

var mission_started = false
var dialogue_text = "Hello, astronaut! You’ve found the spectrometer. Can you collect rock samples and analyze them?"
var current_char_index = 0
var typing_speed = 0.05

var rock_types = ["granite", "sulfur", "basalt"]
var rock_positions = [Vector2(200, 300), Vector2(400, 350), Vector2(600, 280)]
var rock_scene = preload("res://Rock.tscn")

func _ready():
	dialogue_box.visible = false
	choice_box.visible = false
	start_button.visible = false
	start_button.pressed.connect(_on_start_mission_button_pressed)

	yes_button.pressed.connect(_on_yes_pressed)
	no_button.pressed.connect(_on_no_pressed)

	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	start_button.pressed.connect(_on_start_mission_button_pressed)

func _on_body_entered(body):
	if body.name == "Player" and not mission_started:
		dialogue_box.visible = true
		start_typing_dialogue()
		spawn_rocks()  # Spawn rocks when player enters area

func _on_body_exited(body):
	if body.name == "Player":
		dialogue_box.visible = false
		choice_box.visible = false
		current_char_index = 0
		dialogue_label.text = ""

func start_typing_dialogue():
	current_char_index = 0
	current_char_index = 0
	dialogue_label.text = ""
	await _type_dialogue()

func _type_dialogue():
	if current_mode == DialogueMode.GREETING:
		while current_char_index < dialogue_text.length():
			dialogue_label.text += dialogue_text[current_char_index]
			current_char_index += 1
			await get_tree().create_timer(typing_speed).timeout
		choice_box.visible = true  # Show Yes/No

	elif current_mode == DialogueMode.MISSION:
		while current_line_index < mission_dialogue_lines.size():
			var line = mission_dialogue_lines[current_line_index]
			dialogue_label.text = ""
			for char in line:
				dialogue_label.text += char
				await get_tree().create_timer(typing_speed).timeout
			current_line_index += 1
			await get_tree().create_timer(0.5).timeout
		
		# All lines done — show Start Mission button
		start_button.visible = true

func _on_yes_pressed():
	print("Player accepted the mission!")
	choice_box.visible = false
	# Proceed with mission logic
	current_mode = DialogueMode.MISSION
	start_typing_dialogue()

func _on_no_pressed():
	print("Player declined the mission.")
	choice_box.visible = false
	# Optionally close the dialogue or exit interaction
	
func _on_start_mission_button_pressed():
	mission_started = true
	start_button.visible = false
	spawn_rocks()  # Spawn 5 rocks, or however many you want

func spawn_rocks():
	var rock_data = [
		{ "type": "granite", "pos": Vector2(200, 300), "scale": Vector2(0.3, 0.3) },
		{ "type": "sulfur", "pos": Vector2(400, 350), "scale": Vector2(0.3, 0.3) },
		{ "type": "basalt", "pos": Vector2(600, 280), "scale": Vector2(0.3, 0.3) }
	]

	for data in rock_data:
		var rock = rock_scene.instantiate()
		rock.position = data["pos"]
		rock.set_type(data["type"])  # Set the rock type (granite, sulfur, basalt)
		rock.scale = data["scale"]
		get_tree().current_scene.add_child(rock)
	
var mission_dialogue_lines = [
	"🧑‍🚀 Mission: Use the spectrometer to analyze the wavelength of three rock samples and determine their planet of origin",
	"",
	"Objectives:",
	"1. Collect Rock Samples",
	"2. Analyze Samples using the Spectrometer",
	"3. Identify the Planet",
	"",
	"Ready?",
]

enum DialogueMode { GREETING, MISSION }
var current_mode = DialogueMode.GREETING
var current_line_index = 0
