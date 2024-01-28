extends Node

# this will not work until I make diogo accept my little Godot change, though I will program as if he did
# everything will be commented so the compiler doesn't kill me
#			Edgar

#I have prematurely imported the addon without diogo
#I hope he doesn't kill me later
#			Edgar


var buzzHid : Hid

func _ready():
	buzzHid = Hid.new();
	buzzHid.open(1356, 2)
	pass


#this should be a static variable inside the function, but gdscript
var lightsOn : Array[bool] = [0, 0, 0, 0, 0] 
# Called when the node enters the scene tree for the first time.
func buzzLightsOn(buzzerID : int, toggle : bool):
	if buzzerID <= 0 || buzzerID >=5:
		print_debug("BuzzerID out of bounds")
		return

	lightsOn[buzzerID] = toggle;
	var writeData : PackedByteArray
	
	writeData.append(0x00)
	
	for i in 5:
		if lightsOn[i]:
			writeData.append(0xFF)
		else:
			writeData.append(0x00)
	buzzHid.write(writeData)
	
	pass

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		for i in range(1, 5):
			buzzLightsOn(i, false)

