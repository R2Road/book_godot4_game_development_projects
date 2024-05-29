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
