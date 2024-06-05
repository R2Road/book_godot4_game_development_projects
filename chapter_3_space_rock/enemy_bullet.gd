extends Area2D



#
#
#
@export var speed = 1000



#
################################ override ################################
#
func _process( delta ):
	position += transform.x * speed * delta



#
################################   user   ################################
#
func start( _pos, _dir ):
	position = _pos
	rotation = _dir.angle()



#
################################  signal  ################################
#
func _on_body_entered(body):
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
