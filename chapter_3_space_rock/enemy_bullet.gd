extends Area2D



#
#
#
@export var speed = 1000



#
# override
#
func _process( delta ):
	position += transform.x * speed * delta



#
#
#
func start( _pos, _dir ):
	position = _pos
	rotation = _dir.angle()



#
#
#
func _on_body_entered(body):
	queue_free()
