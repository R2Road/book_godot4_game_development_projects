extends Area2D



#
# export variable
#
@export var speed = 1000



#
#
#
var velocity = Vector2.ZERO



#
# override
#
func _process( delta ):
	position += velocity * delta



#
#
#
func start( _transform ):
	transform = _transform
	velocity = transform.x * speed



#
# signal
#
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()