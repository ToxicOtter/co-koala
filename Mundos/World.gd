extends Node

var p = 1

func _ready():
	$AudioStreamPlayer.play() 

func _physics_process(delta):
	if Input.is_action_pressed("1"):
		atirar.perai = 1
	if Input.is_action_pressed("2"):
		atirar.perai = 2

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play() 

func _on_Pause_toggled(button_pressed):
	$CanvasLayer/Pause.pause()

func _on_TextureButton_toggled(button_pressed):
	if button_pressed == true:
		$AudioStreamPlayer.stream_paused = true
	elif button_pressed == false:
		$AudioStreamPlayer.stream_paused = false

func _on_Voltar_toggled(button_pressed):
	if button_pressed == true:
		$CanvasLayer/Voltar.visible = false
	if button_pressed == false:
		$CanvasLayer/Voltar.visible = true
