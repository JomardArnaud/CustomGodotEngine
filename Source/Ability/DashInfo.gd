class_name DashInfo
extends Resource

# entity's speed during the dash
@export var power = 1200
# Couldown for the dash in second
@export var cd : float
# dash's duration in second
@export var duration : float

# speed's holder buffer at the dash's start
var baseSpeedHolder : float
