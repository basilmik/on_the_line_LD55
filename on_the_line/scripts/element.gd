class_name element
extends Sprite2D

const COL_COUNT = 6
const ROW_COUNT = 5

@onready var this_item=$"."
@onready var shape=$shape

var control
var group


var is_lit = false
var is_checked = false
var changed_state = false

const BLUE = 0
const YELLOW = 1
const RED = 2

var is_on_call = false

var row
var col


@onready var top = $top
@onready var right = $right
@onready var bot_right = $bot_right
@onready var bot_left = $bot_left
@onready var left = $left

@onready var candles=[$top, $right, $bot_right, $bot_left, $left]
var candle_states =[]

var candle_src=["res://pics/blue_light.png", "res://pics/yellow_light.png", "res://pics/red_light.png"]

var left_touch
var right_touch
var top_touch_left
var top_touch_right
var bot_left_touch
var bot_right_touch
var bot_left_side_touch
var bot_right_side_touch

func set_placement():
	var group = get_parent().element_array
	var x = 0
	var y = 0
	right_touch=null
	left_touch=null
	top_touch_left=null
	top_touch_right=null
	bot_left_touch=null
	bot_right_touch=null
	bot_left_side_touch = null
	bot_right_side_touch = null
	
	if (col < COL_COUNT-1): # 0 1 2 3 4 columns, if == 4 -> no right neigh
		x = col+1
		y = row
		right_touch = group[y*COL_COUNT + x].left
		bot_right_side_touch = group[y*COL_COUNT + x].bot_left

		
	if (col > 0): # 0 1 2 3 4 columns, if == 0 -> no left neigh
		x = col-1
		y = row
		left_touch = group[y*COL_COUNT + x].right
		bot_left_side_touch = group[y*COL_COUNT + x].bot_right
	

	if (row%2 == 1): #1, 3, 5... COL_COUNT

		if (row > 0): # up one
			y = row - 1
			x = col
			top_touch_left = group[y*COL_COUNT + x].bot_right
			
			if (col < COL_COUNT-1): #up and right
				y = row - 1
				x = col + 1
				top_touch_right = group[y*COL_COUNT + x].bot_left
		

		if (row < ROW_COUNT-1): # down
			y = row + 1
			x = col
			bot_left_touch = group[y*COL_COUNT + x].top
			
			if (col < COL_COUNT-1): #down and left or right
				y = row + 1
				x = col + 1
				bot_right_touch = group[y*COL_COUNT + x].top
				
	else: # 0, 2
		if (row > 0): # up one
			y = row - 1
			x = col
			top_touch_right = group[y*COL_COUNT + x].bot_left
			
			if (col > 0): #up and right
				y = row - 1
				x = col - 1
				top_touch_left = group[y*COL_COUNT + x].bot_right

		if (row < ROW_COUNT-1): # down
			y = row + 1
			x = col
			bot_right_touch = group[y*COL_COUNT + x].top
			
			if (col > 0): #down and left or right
				y = row + 1
				x = col - 1
				bot_left_touch = group[y*COL_COUNT + x].top

var has_made_mistake = false
var mistake_counter = -1
var correct_counter = 1

func reset_neight():
	if (top_touch_left != null):
		if (top_touch_left.texture!= null):
			if (top_touch_left.texture != load(candle_src[candle_states[0]])):
				has_made_mistake=true
				mistake_counter-=1
				top_touch_left.get_parent().cancel_call()
			else:
				correct_counter+=1
				top_touch_left.texture=load(candle_src[candle_states[0]])
	

	if (top_touch_right != null):
		if( top_touch_right.texture!= null):
			if (top_touch_right.texture != load(candle_src[candle_states[0]])):
				has_made_mistake=true
				mistake_counter-=1
				top_touch_right.get_parent().cancel_call()
			else:
				correct_counter+=1
				top_touch_right.texture=load(candle_src[candle_states[0]])
#
	if (left_touch != null):
		if(left_touch.texture!= null):
			if (left_touch.texture != load(candle_src[candle_states[4]])):
				has_made_mistake=true
				mistake_counter-=1
				left_touch.get_parent().cancel_call()
			else:
				correct_counter+=1
				left_touch.texture=load(candle_src[candle_states[4]])

	if (right_touch != null):
		if(right_touch.texture!= null):
			if (right_touch.texture != load(candle_src[candle_states[1]])):
				has_made_mistake=true
				mistake_counter-=1
				right_touch.get_parent().cancel_call()
			else:
				correct_counter+=1
				right_touch.texture=load(candle_src[candle_states[1]])		
		

	if (bot_right_side_touch != null):
		if(bot_right_side_touch.texture!= null):
			if (bot_right_side_touch.texture != load(candle_src[candle_states[2]])):
				has_made_mistake=true
				mistake_counter-=1
				bot_right_side_touch.get_parent().cancel_call()
			else:
				correct_counter+=1
				bot_right_side_touch.texture=load(candle_src[candle_states[2]])
		
	if (bot_left_side_touch != null):
		if(bot_left_side_touch.texture!= null):
			if (bot_left_side_touch.texture != load(candle_src[candle_states[3]])):
				has_made_mistake=true
				mistake_counter-=1
				bot_left_side_touch.get_parent().cancel_call()
			else:
				correct_counter+=1
				bot_left_side_touch.texture=load(candle_src[candle_states[3]])		
		
	if (bot_left_touch != null):
		if (bot_left_touch.texture!= null):
			if (bot_left_touch.texture != load(candle_src[candle_states[3]])):
				has_made_mistake=true
				mistake_counter-=1
				bot_left_touch.get_parent().cancel_call()
			else:
				correct_counter+=1
				bot_left_touch.texture=load(candle_src[candle_states[3]])

	if (bot_right_touch != null):
		if (bot_right_touch.texture!= null):
			if (bot_right_touch.texture != load(candle_src[candle_states[2]])):
				has_made_mistake=true
				mistake_counter-=1
				bot_right_touch.get_parent().cancel_call()
			else:
				correct_counter+=1
				bot_right_touch.texture=load(candle_src[candle_states[2]])
				
	if (has_made_mistake):
		control.score_counter = control.score_counter + mistake_counter
		control.msg_text = str(mistake_counter)
		#print(control.msg_text)
		control.has_score_updated=true
		mistake_counter= -1
	else:
		#print(control.msg_text)
		#if (control.msg_text != "-6"):
		control.msg_text = "+"+str(correct_counter)
		control.score_counter+=correct_counter
		correct_counter=1

func cancel_call():
	has_made_mistake=false

	candle_states=[]
	is_on_call = false
	changed_state = true
	is_lit = 0
	load_candles()
	pass
		
# Called when the node enters the scene tree for the first time.
func _ready():
	this_item.texture = load("res://pics/no_incoming.png")	
	group=get_parent()
	control=group.get_parent()
	load_candles()

var is_outgoing = false
var sec = 0
var cnt = 0
var timeout = 10
var is_to_blink = false

func _process(delta):
	
	if (is_on_call):
		cnt+=1

	if (cnt == 60):
		sec+=1
		cnt = 0

	if (is_on_call):
		if ((timeout-sec)<=6 and (timeout-sec)>2):
			if (cnt %20 == 0):
				is_to_blink = true
				changed_state=true
		elif ((timeout-sec)<=2):
			if (cnt %10 == 0 ):
				is_to_blink = true
				changed_state=true
		else:
			is_to_blink = false
			changed_state=true
		

	if (sec == timeout and is_on_call):
		cancel_call()
		sec = 0
		timeout = randi()%30+20 #call length
		

		
	if (changed_state):
		set_pic_by_state()
		changed_state=false

	pass




func _on_shape_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print("click item: is holding?", control.is_holding)
			if (control.is_holding):
				changed_state = true
				candle_states=control.hold_candles
				load_candles() #sets the same candles as where at incoming
				reset_neight()
				
				if (is_on_call):
					control.score_counter -= 6
					control.msg_text = "-6!"
					control.has_score_updated = false
					control.update_score()
					pass
					
				is_on_call = true
				control.connect_call_to_item() #sets incoming candles and state zero


func _on_shape_mouse_entered():
	if (!is_on_call and control.is_holding):
		is_lit = 1
		changed_state = true
	pass # Replace with function body.


func _on_shape_mouse_exited():
	if (!is_on_call and control.is_holding):
		is_lit = 0
		changed_state = true
	pass # Replace with function body.


func set_pic_by_state():

	if (is_on_call):
		if (is_to_blink):
			if (this_item.texture == load("res://pics/income_hover.png")):
				this_item.texture = load("res://pics/about_to_end.png")
			else:
				this_item.texture = load("res://pics/income_hover.png")
		else:
			this_item.texture = load("res://pics/income_hover.png")
	elif(is_lit):
		this_item.texture = load("res://pics/taken.png")
	else:
		this_item.texture = load("res://pics/no_incoming.png")
		
	

func load_by_state(id):
	if (!candle_states.is_empty()):
		candles[id].texture=load(candle_src[candle_states[id]])
	else:
		candles[id].texture = null
	
func load_candles():
	for i in 5:
		load_by_state(i)
	
