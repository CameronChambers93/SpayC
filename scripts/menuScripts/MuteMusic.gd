extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass


func _on_MuteMusic_pressed():
	if (AudioServer.get_stream_global_volume_scale() == 0):
		AudioServer.set_stream_global_volume_scale(1)
	else:
		AudioServer.set_stream_global_volume_scale(0)
	pass # replace with function body
