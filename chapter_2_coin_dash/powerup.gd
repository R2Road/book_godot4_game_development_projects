# 모든 스크립트의 첫줄은 어떤 노드를 상속하는지를 나타낸다.
extends Area2D


var screensize = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func pickup():
	# + set_deferred() : https://docs.godotengine.org/en/3.2/classes/class_object.html#class-object-method-set-deferred
	#  > 현재 프레임의 물리 단계 후에 지정된 속성에 새 값을 할당합니다.
	#  > 이는 call_deferred를 통해 set 을 호출하는 것과 동일합니다 .call_deferred("set", property, value)
	
	# Collision : Off
	$CollisionShape2D.set_deferred( "disabled", "true" )
	
	var tw = create_tween().set_parallel().set_trans( Tween.TRANS_QUAD )	
	# Scale : Up
	tw.tween_property( self, "scale", scale * 3, 0.3 )	
	# Alpha : Down
	tw.tween_property( self, "modulate:a", 0.0, 0.3 )
	
	# tween 종료 까지 대기
	await tw.finished
	
	# + queue_free()
	# 오브젝트를 즉시 삭제하지 않는다.
	#  > 삭제 대기열에 추가.
	#  > 현재 프레임이 끝날 때 처리.
	# 안전하다.
	queue_free()


func _on_life_time_timeout():
	pass # Replace with function body.
