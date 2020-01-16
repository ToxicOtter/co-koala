extends Area2D

var ataque = 10
var target

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
	if target:
		rotation = (target.position - position).angle()

func _on_segue_body_entered(body):
	if body.is_in_group("enemies"):
		body.receberdano(ataque)
		queue_free()


func _on_segue_area_entered(area):
	if area.is_in_group("koalla"):
		queue_free()
