extends CharacterBody2D

const SPEED = 300.0

@export var inv: Inventory

func player():
	pass

func collect(item):
	inv.insert(item)

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO  # Reset velocity each frame

	# Get input directions
	var x_input := Input.get_axis("ui_left", "ui_right")
	var y_input := Input.get_axis("ui_up", "ui_down")

	velocity.x = x_input * SPEED
	velocity.y = y_input * SPEED

	move_and_slide()

	# Handle animation
	if x_input != 0 or y_input != 0:
		$AnimatedSprite2D.play("Walk")
		
		# Flip sprite horizontally based on direction
		if x_input != 0:
			$AnimatedSprite2D.flip_h = x_input < 0
	else:
		$AnimatedSprite2D.play("idle")
