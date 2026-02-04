class_name ItemMover extends Area2D

var _outputTarget: ItemReceiver
var _outputDir: Facing.CARDINAL
var _inputReceiver: ItemReceiver
var _shift: int

func initialize(outputDir: Facing.CARDINAL, inputReceiver: ItemReceiver, shift: int = 64 ) -> void:
	_outputDir = outputDir
	_shift = shift
	_inputReceiver = inputReceiver
	ORCHESTRATOR.registerPoll(poll, 2)
	ORCHESTRATOR.registerExecute(pushItem, 2)

func poll() -> void:
	_outputTarget = pollForTarget()

func pollForTarget() -> ItemReceiver:
	var query = PhysicsPointQueryParameters2D.new()
	query.collide_with_areas = true
	query.position = Facing.adjacent(_outputDir, global_position, _shift)

	var hits: Array[Dictionary] = get_world_2d().direct_space_state.intersect_point(query, 8)
	hits = hits.filter(func(d):
		if d.collider is not ItemReceiver:
			return false
		var i = d.collider as ItemReceiver
		return i.isFacingValid(_outputDir)
	)

	if hits.size() == 0:
		return null

	if hits.size() > 1:
		push_warning("Multiple receivers in one square at position: " + str(query.position))

	return hits[0].collider
		
func pushItem() -> void:
	if not _outputTarget:
		return
	if _outputTarget.isLocked():
		return
	var item = _inputReceiver.getItem()
	if not item:
		return
	item.global_position = Facing.adjacent(_outputDir, global_position, _shift)
	
func isLocked() -> bool:
	if not _outputTarget:
		return true
	return _outputTarget.isLocked()
		
