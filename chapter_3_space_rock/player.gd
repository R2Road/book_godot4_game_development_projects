extends RigidBody2D

#
# export variable
#
@export var engine_power = 500
@export var spin_power = 800

@export var bullet_scene : PackedScene
@export var fire_rate = 0.25



#
#
#
var screensize = Vector2.ZERO

#
#
#
var thrust = Vector2.ZERO
var rotation_dir = 0

#
# enum Name {} 의 형태로 입력해도 된다.
#
enum { INIT, ALIVE, INVULNERABLE, DEAD }
var state = INIT

#
#
#
var can_shoot = true




#
# override
#
func _ready():
	screensize = get_viewport_rect().size
	
	change_state( ALIVE )
	
	$GunCooldown.wait_time = fire_rate

func _process( delta ):
	get_input()

func _physics_process( delta ):
	constant_force = thrust
	constant_torque = rotation_dir * spin_power

#
# RigidBody의 위치나 기타 물리 속성을 직접 변경하는 경우 _integrate_forces 함수를 사용한다.
#
func _integrate_forces( physics_state ):
	var xform = physics_state.transform
	xform.origin.x = wrapf( xform.origin.x, 0, screensize.x ) # wrapf == clamp
	xform.origin.y = wrapf( xform.origin.y, 0, screensize.y )
	physics_state.transform = xform




#
#
#	
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
	state = new_state

func get_input():
	thrust = Vector2.ZERO
	if state in [DEAD, INIT]:
		return
	if Input.is_action_pressed( "thrust" ):
		thrust = transform.x * engine_power
	
	rotation_dir = Input.get_axis( "rotate_left", "rotate_right" )
	
	if Input.is_action_pressed( "shoot" ) and can_shoot:
		shoot()

func shoot():
	if state == INVULNERABLE:
		return
		
	can_shoot = false
	$GunCooldown.start()
	var b = bullet_scene.instantiate()
	get_tree().root.add_child( b )
	b.start( $Muzzle.global_transform )
