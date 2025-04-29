extends StaticBody2D

@export var item: invItem
var player = null

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player = body
		playerCollect()
		self.queue_free()
		
func playerCollect():
	player.collect(item)
