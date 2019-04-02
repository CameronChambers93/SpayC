extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_DoorLock_area_enter( area ):
	print("hello")
	if area.get_name() == "Shock":
		print('yes')
		get_node("Door").queue_free()
