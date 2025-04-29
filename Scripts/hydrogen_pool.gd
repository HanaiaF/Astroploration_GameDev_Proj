extends Node2D

var state = "hydrogen"
var player_in_area = false

var full_hydrogen_bottle = preload("res://Inventory Items/bottle-sprite.tscn")

@export var item: invItem
var player = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if state == "no hydrogen":
		$AnimatedSprite2D.play("no_hydrogen")
	if state == "hydrogen":
		$AnimatedSprite2D.play("hydrogen")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no hydrogen"
				drop_bottle()

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body



func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false

func drop_bottle():
	var bottle_instance = full_hydrogen_bottle.instantiate()
	bottle_instance.global_position = $Marker2D.global_position
	player.collect(item)
	get_parent().add_child(bottle_instance)
