extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# note that body ^ here refers to whomever enters this collision box
	body.equip_hat() # Call a method on the player to change appearance
	queue_free()# Remove this item from the scene
