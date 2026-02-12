extends Node

@onready var tv = $TV
@onready var geladeira = $Geladeira
@onready var porta = $Porta

func ligar_tv():
    tv.play()

func desligar_tv():
    tv.stop()

func abrir_porta():
    porta.play()
