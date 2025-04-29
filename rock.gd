extends Area2D
##
signal rock_picked_up(type)

var type := ""
@onready var sprite: AnimatedSprite2D = $Rock/AnimatedSprite2D

func set_type(rock_type: String):
	type = rock_type
	print("Setting type to: ", type)  # Debugging line
	if sprite:
		match type:
			"granite":
				sprite.play("granite")
			"basalt":
				sprite.play("basalt")
			"sulfur":
				sprite.play("sulfur")
func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
##
##func _on_body_entered(body):
	##if body.name == "Player":
		##emit_signal("rock_picked_up", type)
		##queue_free()

#@onready var granite_sprite = $GraniteSp
#@onready var sulfur_sprite = $SulfurSp
#@onready var basalt_sprite = $BasaltSp
#
#var rock_type := "granite"
#
#func _ready():
	#set_type(rock_type)
#
#func set_type(type: String):
	#granite_sprite.visible = false
	#sulfur_sprite.visible = false
	#basalt_sprite.visible = false
#
	#match type:
		#"granite":
			#granite_sprite.visible = true
		#"sulfur":
			#sulfur_sprite.visible = true
		#"basalt":
			#basalt_sprite.visible = true
			#
			#
