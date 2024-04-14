extends Node2D

const BLUE = 0
const YELLOW = 1
const RED = 2


var is_holding = false
var hold_candles = []
var item_held = null

var time_value = 0
var sec = 0
var cnt = 0
var score_counter = 0
var msg_text = 0
var has_score_updated = true


func _ready():
	$user_stats.total_time.text = "time: "+str(time_value)
	pass # Replace with function body.

@onready var line = $Line2D

func _process(delta):


	cnt+=1

	if (cnt == 60):
		sec+=1
		cnt = 0
	if (time_value!=sec):
		time_value = sec
		$user_stats.total_time.text = "time: "+str(time_value)
	
	if (has_score_updated):
		update_score()
		has_score_updated=false

	
	pass
	
	
func update_score():
	print("score_counter ",str(msg_text))
	print("msg_text ",str(score_counter))
	$user_stats.score.text = "score: "+ str(score_counter)
	$user_stats.msg.text = "last: "+str(msg_text)
	
func connect_call_to_item():
	update_score()
	#has_score_updated=true
	item_held.connect_call()

