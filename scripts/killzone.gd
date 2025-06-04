extends Area2D

@onready var timer: Timer = $Timer

func _on_area_entered(area: Area2D) -> void:
	print("You Died")
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()	
