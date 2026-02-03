class_name Orchestrator extends Node

enum NOTE {
	EIGHTH = 1,
	QUARTER = 2,
	HALF = 4,
	WHOLE = 8,
}

signal _poll
signal _execute

var _timer: Timer
var _eighths := 1
var _beatsPerMinute := 120

var _shouldPoll := false
var _shouldExecute := false

func _ready() -> void:
	get_tree().scene_changed.connect(applyOrchestration)
	applyOrchestration()

func applyOrchestration():
	if _timer:
		_timer.queue_free()
	_timer = Timer.new()
	var beatsPerSecond = _beatsPerMinute / 60.0
	var eighthsPerSecond = beatsPerSecond * 2
	_timer.wait_time = 1.0 / eighthsPerSecond
	var scene = get_tree().current_scene
	scene.add_child(_timer)
	_timer.timeout.connect(_toggleBroadcastOn)
	_timer.start()

func wrapCallback(callback: Callable, eighths: int) -> Callable:
	return func():
		if _eighths % eighths == 0:
			callback.call()
			
func registerPoll(callback: Callable, eighths: int) -> void:
	callback = wrapCallback(callback, eighths)
	self._poll.connect(callback)
	
func registerExecute(callback: Callable, eighths: int) -> void:
	callback = wrapCallback(callback, eighths)
	self._execute.connect(callback)

func _toggleBroadcastOn():
	_shouldPoll = true

func _physics_process(_delta: float) -> void:
	if _shouldPoll:
		emit_signal("_poll")
		_shouldPoll = false
		_shouldExecute = true
	elif _shouldExecute:
		emit_signal("_execute")
		_shouldExecute = false
		_eighths += 1
		if _eighths == 9:
			_eighths = 1
