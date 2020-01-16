extends Area2D

var ataque = 20

var speed = 250
var velocity = Vector2()

func _ready():
	$AnimatedSprite.play("default")
	set_as_toplevel(true)

func start(pos, dir):
	position = pos
	rotation_degrees = rad2deg(dir)+90
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_bala_area_entered(area):
	if area.is_in_group("koalla"):
		queue_free()

func _on_bala_body_entered(body):
	if body.is_in_group("enemies"):
		body.receberdano(ataque)
		queue_free()
