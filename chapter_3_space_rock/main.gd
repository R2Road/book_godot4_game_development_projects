extends Node2D



#
# export
#
@export var rock_scene : PackedScene
@export var enemy_scene : PackedScene



#
#
#
var screensize = Vector2.ZERO

var level = 0
var score = 0
var playing = false



#
# override
#
func _ready():
	screensize = get_viewport().get_visible_rect().size
	for i in 3:
		spawn_rock( 3 )

func _process( delta ):
	if not playing:
		return
	
	if get_tree().get_nodes_in_group( "rocks" ).size() == 0:
		new_level()

func _input( event ):
	if event.is_action_pressed( "pause" ):
		if not playing:
			return
		
		get_tree().paused = not get_tree().paused
		var message = $HUD/VBoxContainer/Message
		if get_tree().paused:
			message.text = "Paused"
			message.show()
		else:
			message.text = ""
			message.hide()
			



#
#
#
func new_game():
	# 이전 게임의 바위가 남아 있으면 제거한다.
	get_tree().call_group( "rocks", "queue_free" )
	level = 0
	score = 0
	$HUD.update_score( score )
	$HUD.show_message( "Get Ready!" )
	$Player.reset()
	await $HUD/Timer.timeout
	playing = true

func new_level():
	level += 1
	$HUD.show_message( "Wave %s" % level )
	for i in level:
		spawn_rock( 3 )
		
	$EnemyTimer.start( randf_range( 5, 10 ) )

func spawn_rock( size, pos = null, vel = null ):
	if pos == null:
		$RockPath/RockSpawn.progress = randi( )
		pos = $RockPath/RockSpawn.position
		
	if vel == null:
		vel = Vector2.RIGHT.rotated( randf_range( 0, TAU ) ) * randf_range( 50, 125 )
	
	var r = rock_scene.instantiate()
	r.screensize = screensize
	r.start( pos, vel, size )
	call_deferred( "add_child", r )
	
	# Connect Signal
	r.exploded.connect( self._on_rock_exploded )

func game_over():
	playing = false
	$HUD.game_over()



#
#
#
func _on_rock_exploded( size, radius, pos, vel ):
	score += ( 10 * size )
	
	if size <= 1:
		return
	
	for offset in [-1, 1]:
		#
		# 폭발하는 바위와 플레이어를 기준으로 수평 이동한 위치에 새 바위를 생성
		#
		# + Vector2 direction_to(to: Vector2) const
		#   > Returns the normalized vector pointing from this vector to to.
		#   > This is equivalent to using (b - a).normalized().
		#
		# + Vector2 orthogonal() const
		#   > Returns a perpendicular vector rotated 90 degrees counter-clockwise
		#   > compared to the original, with the same length.
		#
		var dir = $Player.position.direction_to( pos ).orthogonal() * offset
		var newpos = pos + ( dir * radius )
		
		var newvel = dir * vel.length() * 1.1
		spawn_rock( size - 1, newpos, newvel )
