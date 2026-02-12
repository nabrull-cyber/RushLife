extends Node

@onready var motor = $Motor
@onready var freio = $Freio
@onready var radio = $Radio

func ligar_motor():
    motor.play()

func desligar_motor():
    motor.stop()

func tocar_freio():
    freio.play()

func ligar_radio():
    radio.play()

func desligar_radio():
    radio.stop()
