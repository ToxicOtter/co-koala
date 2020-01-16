extends Area2D

var speed = 250
var velocity = Vector2()
var ataque = 20
onready var player = get_node("../Player")

func _ready():
	$AnimatedSprite.play("default")

func start(pos, dir):
	position = pos
	rotation_degrees = rad2deg(dir)+90
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_hit_box_body_entered(body):
	if body.is_in_group("players"):
		body.receberdano(ataque)
		queue_free()




func _on_hit_box_area_entered(area):
	if area.is_in_group("koala"):
		queue_free()
