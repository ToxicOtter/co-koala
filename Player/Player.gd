extends KinematicBody2D

#movimento
const speed = 200
var motion = Vector2()

#tiro
export (PackedScene) var bala
var can_shoot = true
var poison_shoot = true
export (PackedScene) var veneno

var andando = 0

var vida_max = 100
var vida = 500
signal atualizar_vida(vida)

func _ready():
	emit_signal("atualizar_vida", vida)
	$atirar_veneno.start()

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
	
	if Input.is_action_pressed("ui_up"):
		motion.y = - speed
		$AnimatedSprite.play("default")
		andando = 2
	else:
		motion.x = 0
		motion.y = 0
		andando = 0
	if Input.is_action_pressed("ui_down"):
		motion.y =   speed
		andando = 1
	if Input.is_action_pressed("ui_left"):
		motion.x =  - speed
		$AnimatedSprite.play("default")
		andando = 3
	elif Input.is_action_pressed("ui_right"):
		motion.x =  speed
		$AnimatedSprite.play("default")
		andando = 4
	if Input.is_action_pressed("click"):
		if can_shoot:
			shoot(get_global_mouse_position())
	move_and_slide(motion)


func shoot(pos):
	var a = (pos - global_position).angle()
	can_shoot = false
	$ShootTimer.start()
	match atirar.perai:
		1:
			var b = bala.instance()
			b.start(global_position, a + rand_range(-0.05, 0.05))
			get_parent().add_child(b)
		2:
			if poison_shoot == true:
				$"../botões/Button2".modulate = Color(0,0,0,255)
				var c = veneno.instance()
				c.start(global_position, a + rand_range(-0.05, 0.05))
				get_parent().add_child(c)
				poison_shoot = false
				$atirar_veneno.start()
				atirar.perai = 1


func _on_ShootTimer_timeout():
	can_shoot = true

func receberdano(ataque):
	vida = vida - ataque
	emit_signal("atualizar_vida", vida)
	if vida <= 0:
		vida = 0
	if vida == 0:
		get_tree().change_scene("res://Player/morreu.tscn")


func _on_Timer_timeout():
	var ataque = 10
	receberdano(ataque)

func _on_Timer2_timeout():
	$Timer.stop()


func _on_atirar_veneno_timeout():
	poison_shoot = true
	$"../botões/Button2".modulate = Color(1,1,1,1)
