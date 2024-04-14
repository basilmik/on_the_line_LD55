class_name income_class
extends Sprite2D

@onready var control = $".."
@onready var this_item=$"."
@onready var shape=$shape


const NO_INCOME_JUST = 0
const NO_INCOME_HOVERED = 1
const INCOMING_JUST = 2
const INCOMING_HOVERED = 3

var is_incoming = false
var is_hovered = false
var changed_state = false
var is_being_held = false

@onready var candles=[$top, $right, $bot_right, $bot_left, $left]
var candle_states = []
var candle_src=["res://pics/blue_light.png", "res://pics/yellow_light.png", "res://pics/red_light.png"]

var cnt = 0
var sec = 0
var timeout=0
var wait_time_cnt = 0


const BLUE = 0
const YELLOW = 1
const RED = 2

const WAIT_MAX = 25

var max_wait = WAIT_MAX
func _ready():
	max_wait=WAIT_MAX + (-1)*(randi()%2)+randi()%3
	timeout=randi()%10 + 1
	load_candles()
	set_pic_by_state()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if (changed_state):
		set_pic_by_state()
		changed_state = false
		
	if Input.is_action_just_pressed("q"):
		if (is_being_held):
			rotate_left()
		
	if Input.is_action_just_pressed("e"):
		if (is_being_held):
			rotate_right()
		
	cnt+=1
	
		
	if (wait_time_cnt >= max_wait):
		wait_time_cnt = 0
		connect_call()
		changed_state = true
		control.score_counter -= 2
		control.msg_text = "-2"
		control.has_score_updated=true
		
	if (cnt == 60):
		cnt = 0
		sec+=1
		if (is_incoming):
			wait_time_cnt+=1
	
	if (max_wait-wait_time_cnt <= 5):
		$wait_time_left.add_theme_color_override("font_color", Color.RED)
	else:
		$wait_time_left.add_theme_color_override("font_color", Color.BLACK)

	#$wait_time_left.text=str(max_wait-wait_time_cnt)

	if (is_incoming):
		$wait_time_left.text=str(max_wait-wait_time_cnt)
	else:
		$wait_time_left.text=""
	
	if (sec == timeout):
		create_call()
		sec = 0
		
	pass


func load_by_state(id):
	if (!candle_states.is_empty()):
		candles[id].texture=load(candle_src[candle_states[id]])
	else:
		candles[id].texture=null
	
func load_candles():
	for i in 5:
		load_by_state(i)

func create_call():
	if (!is_incoming):
		is_incoming = true

		changed_state=true
		candle_states=[randi()%3, randi()%3, randi()%3, randi()%3, randi()%3]
		load_candles()

func connect_call():
	is_incoming = false
	is_being_held=false
	control.is_holding = false
	
	control.hold_candles = []
	wait_time_cnt = 0
	changed_state=true
	candle_states=[]
	load_candles()
	
	sec = 0
	timeout=randi()%WAIT_MAX + 2 # before new call
	#print(timeout)
	
	control.item_held=null


	
func set_pic_by_state():	
	if (is_being_held):
		this_item.texture = load("res://pics/taken.png")
	else:	
		var state = 2*int(is_incoming)+int(is_hovered)

		if (state == NO_INCOME_JUST or state == NO_INCOME_HOVERED):
			this_item.texture = load("res://pics/no_incoming.png")

		if(state==INCOMING_HOVERED):
			this_item.texture = load("res://pics/income_hover.png")

		if(state==INCOMING_JUST):
			this_item.texture = load("res://pics/income_no_hover.png")
			



func _on_shape_mouse_entered():
	if (is_incoming):
		is_hovered = true
		if (!is_being_held):
			changed_state = true
	pass # Replace with function body.


func _on_shape_mouse_exited():
	if (is_incoming):
		is_hovered = false
		if (!is_being_held):
			changed_state = true
	pass # Replace with function body.



func rotate_left():
	if (!candle_states.is_empty()):
		var el_save = candle_states[0]
		for i in range(0, 4, 1):
			candle_states[i] = candle_states[i+1]
		candle_states[4] = el_save
	load_candles()

func rotate_right():
	if (!candle_states.is_empty()):
		var el_save = candle_states[4]
		for i in range(4, 0, -1):
			candle_states[i] = candle_states[i-1]
		candle_states[0] = el_save
	load_candles()

	



func _on_shape_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if (is_incoming):
				if (is_being_held): # this is held and now is not
					control.is_holding=false
					control.item_held=null
					control.hold_candles=[]
					changed_state = true
					is_being_held=false
					
				else: #was not held and now is		
					if (control.item_held != null): 
						control.item_held.is_being_held = false
						control.item_held.changed_state=true

					is_being_held=true
					control.item_held = this_item
					control.hold_candles = candle_states
					changed_state = true
					control.is_holding=true


