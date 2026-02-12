extends Node

@onready var audio_chuva = $Chuva
@onready var audio_passaros = $Passaros
@onready var audio_cidade = $Cidade

var clima_atual = "SOL"

func atualizar_clima(clima):
    clima_atual = clima
    
    parar_todos()
    
    if clima == "SOL":
        audio_passaros.play()
        audio_cidade.play()
        
    elif clima == "CHUVA":
        audio_chuva.play()
        
    elif clima == "TEMPESTADE":
        audio_chuva.play()

func parar_todos():
    audio_chuva.stop()
    audio_passaros.stop()
    audio_cidade.stop()
