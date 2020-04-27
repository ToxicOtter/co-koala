extends KinematicBody2D

export (PackedScene) var tiro
export (float) var tempo
var can_shoot = true
onready var player = get_node("../Player")
const speed = 200
var move = 0
var motion = Vector2()

onready var timer1 = $veneno
onready var timer2 = $maximo

var andando = 0
var vida = 700
signal atualizar_vida(vida)

func _ready():
	$Timer.wait_time = tempo

func _physics_process(delta):
	match andando:
		0:
			$AnimatedSprite.play("idle")
		1:
			$AnimatedSprite.play("default")
		2:
			$AnimatedSprite.play("default")
		3:
			$AnimatedSprite.play("default")
		4:
			$AnimatedSprite.play("default")
	
	match move:
		0:
			motion.x = - speed
			andando = 3
		1:
			motion.x = speed
			andando = 4
		2:
			motion.y = - speed
			andando = 2
		3:
			motion.y = speed
			andando = 1
	
	move_and_slide(motion)
	if can_shoot:
			shoot(player.position)

func shoot(pos):
	var b = tiro.instance()
	var a = (pos - global_position).angle()
	b.start(global_position, a + rand_range(-0.05, 0.05))
	get_parent().add_child(b)
	can_shoot = false
	$Timer.start()

func receberdano(ataque):
	vida = vida - ataque
	emit_signal("atualizar_vida", vida)
	if vida <= 0:
		vida = 0
	if vida == 0:
		queue_free()
		get_tree().change_scene("res://Player/para-bens.tscn")
	pass

func _randomize_movemment():
	move = randi()%4
	$Move.start()

func _on_Timer_timeout():
	can_shoot = true

func _on_Move_timeout():
	_randomize_movemment()

func _on_veneno_timeout():
	var ataque = 10
	receberdano(ataque)

func _on_maximo_timeout():
	$veneno.stop()
