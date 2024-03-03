extends Resource

class_name UnitItem

@export var name: String = ""
@export var texture: Texture2D

@export var max_health: int = 6
@export var attack_cooldown: float = 1.0
@export var attack_damage: int = 2
@export var attack_width: int = 0
@export var attack_dis: int = 2
@export var attack_dir: GlobalEnums.Directions = GlobalEnums.Directions.LEFT
