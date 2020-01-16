extends Area2D

var speed = 250
var velocity = Vector2()

func _ready():
	set_as_toplevel(true)

func start(pos, dir):
	position = pos
	rotation_degrees = rad2deg(dir)+90
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_veneno_body_entered(body):
	if body.is_in_group("enemies"):
		body.timer1.start()
		body.timer2.start()
		queue_free()
