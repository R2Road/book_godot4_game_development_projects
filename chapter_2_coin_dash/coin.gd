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
	# + queue_free()
	# 오브젝트를 즉시 삭제하지 않는다.
	#  > 삭제 대기열에 추가.
	#  > 현재 프레임이 끝날 때 처리.
	# 안전하다.
	queue_free()
