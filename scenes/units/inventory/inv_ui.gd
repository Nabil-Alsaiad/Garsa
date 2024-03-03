extends Control

@onready var inv: Inventory = preload("res://scenes/units/inventory/inventory.tres")
@onready var slots: Array = $NinePatchRect/VBoxContainer.get_children()

func _ready():
	update_slots()

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
