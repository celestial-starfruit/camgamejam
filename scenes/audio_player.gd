extends AudioStreamPlayer


const BUILDING = preload("uid://dk048nwgtwraa")
const TDPHASE = preload("uid://bcate8ilyh1qx")
const TITLE = preload("uid://da2pdkk4ki43s")
const WIN = preload("uid://c5ayqomprvru8")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stream = BUILDING
	bus = "Music"
	play()
