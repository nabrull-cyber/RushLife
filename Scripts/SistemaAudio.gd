extends Node

# =========================
# CONFIGURAÇÕES DE ÁUDIO
# =========================

var modo_audio = "PADRAO" # SUAVE / PADRAO / ULTRA

# Volume geral
var volume_master = 1.0
var volume_ambiente = 1.0
var volume_efeitos = 1.0
var volume_vozes = 1.0

# =========================
# REFERÊNCIAS DE SONS
# =========================

var som_chuva
var som_passos
var som_cidade
var som_motor
var som_radio
var som_tv

# =========================
# INICIALIZAÇÃO
# =========================

func _ready():
    configurar_modo_audio(modo_audio)

# =========================
# CONFIGURAR MODO
# =========================

func configurar_modo_audio(modo):
    modo_audio = modo
    
    if modo == "SUAVE":
        volume_ambiente = 0.5
        volume_efeitos = 0.6
        volume_vozes = 0.7
        
    elif modo == "PADRAO":
        volume_ambiente = 0.8
        volume_efeitos = 0.9
        volume_vozes = 1.0
        
    elif modo == "ULTRA":
        volume_ambiente = 1.0
        volume_efeitos = 1.0
        volume_vozes = 1.0

# =========================
# FUNÇÕES DE SOM
# =========================

func tocar_som(audio_player):
    if audio_player:
        audio_player.volume_db = linear_to_db(volume_master)
        audio_player.play()

func parar_som(audio_player):
    if audio_player:
        audio_player.stop()

func atualizar_volume_master(valor):
    volume_master = valor
