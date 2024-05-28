extends RigidBody2D

#
# enum Name {} 의 형태로 입력해도 된다.
#
enum { INIT, ALIVE, INVULNERABLE, DEAD }
var state = INIT

func _ready():
	change_state( ALIVE )
	
func change_state( new_state ):
	match new_state:
		INIT:
			$CollisionShape2D.set_deferred( "disabled", true )
		ALIVE:
			$CollisionShape2D.set_deferred( "disabled", false )
		INVULNERABLE:
			$CollisionShape2D.set_deferred( "disabled", true )
		DEAD:
			$CollisionShape2D.set_deferred( "disabled", true )
