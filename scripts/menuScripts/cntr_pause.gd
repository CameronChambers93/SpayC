extends Container

var selection = {0: [Vector2(0,0)],
				1: [Vector2(-45, 70)],
				2: [Vector2(-65, 140)],
				3: [Vector2(20, 210)]}

var currentSelection = 0
var originalPosition = Vector2(0,0)
var musicVolume = AudioServer.get_stream_global_volume_scale()
var effectsVolume = AudioServer.get_fx_global_volume_scale()

func _ready():
	set_process(true)
	originalPosition = get_node("Selection").get_pos()

func _process(delta):
	if get_tree().is_paused():
		set_process_input(true)

func _input(event):
	if (Input.is_action_pressed("ui_down")):
		currentSelection = (currentSelection + 1) % 4
		get_node("Selection").set_pos(originalPosition + selection[currentSelection][0])
	if (Input.is_action_pressed("ui_up")):
		currentSelection = (currentSelection + 3) % 4
		get_node("Selection").set_pos(originalPosition + selection[currentSelection][0])
	if (Input.is_action_pressed("ui_accept")):
		if (currentSelection == 0):
			resume()
		elif (currentSelection == 1):
			mute_music()
		elif (currentSelection == 2):
			mute_effects()
		else:
			exit()

func resume():
	self.hide()
	get_tree().set_pause(false)

func mute_music():
	if (AudioServer.get_stream_global_volume_scale() == 0):
		AudioServer.set_stream_global_volume_scale(musicVolume)
		get_node("Mute Music").set_text("Mute Music")
	else:
		AudioServer.set_stream_global_volume_scale(0)
		get_node("Mute Music").set_text("Unmute Music")

func mute_effects():
	if (AudioServer.get_fx_global_volume_scale() == 0):
		AudioServer.set_fx_global_volume_scale(effectsVolume)
		get_node("Mute Effects").set_text("Mute Effects")
	else:
		AudioServer.set_fx_global_volume_scale(0)
		get_node("Mute Effects").set_text("Unmute Effects")

func exit():
	get_node("/root/global").setScene("res://scenes/menuScenes/MainMenu.tscn")
	get_tree().set_pause(false)