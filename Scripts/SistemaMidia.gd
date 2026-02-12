extends Node
class_name SistemaMidia

# PERFIS (ajuda na sua ideia de "sem palavrão")
enum FiltroConteudo { LIVRE, SEM_PALAVRAO }

# Fonte do áudio
enum Fonte { OFFLINE, RADIO, YOUTUBE_LINK }

signal tocando_mudou(ativo: bool)
signal fonte_mudou(fonte: int)
signal musica_mudou(titulo: String)
signal volume_mudou(v: float)

# Config
var filtro: int = FiltroConteudo.SEM_PALAVRAO
var fonte_atual: int = Fonte.RADIO
var volume: float = 0.8

# Estado
var tocando: bool = false
var titulo_atual: String = ""

# Offline (lista de músicas "importadas" / cadastradas)
# No mobile real, você vai precisar de um plugin/bridge pra acessar mídia do telefone.
# Por enquanto a gente deixa estruturado como "biblioteca interna".
var offline_library: Array = [] # [{"id":"m1","titulo":"...","path":"res://..."}]

# Rádio (estações)
# Você pode usar streams próprios ou playlists aprovadas (sem palavrão).
var radio_stations: Array = [] # [{"id":"r1","nome":"Virella Pop","url":"https://..." , "tags":["clean"]}]

# YouTube (não toca dentro do jogo aqui; guarda link e abre externo)
var ultimo_youtube_link: String = ""

func _ready() -> void:
	_carregar_padrao()

func _carregar_padrao() -> void:
	# Offline exemplo (no começo pode ficar vazio)
	offline_library = [
		{"id":"off_1", "titulo":"RushLife Theme (Offline)", "path":"res://Assets/Audio/Music/theme.ogg"},
	]

	# Rádio exemplo (urls placeholders — você troca depois)
	radio_stations = [
		{"id":"rad_1", "nome":"Virella Pop (Clean)", "url":"https://example.com/radio_pop_clean", "tags":["clean"]},
		{"id":"rad_2", "nome":"Virella Chill (Clean)", "url":"https://example.com/radio_chill_clean", "tags":["clean"]},
	]

func set_volume(v: float) -> void:
	volume = clamp(v, 0.0, 1.0)
	emit_signal("volume_mudou", volume)

func set_filtro(novo: int) -> void:
	filtro = novo
	# Se estiver no rádio, troca a lista para estações "clean"
	if fonte_atual == Fonte.RADIO:
		# nada a fazer aqui por enquanto, mas UI pode filtrar as opções
		pass

func play_offline(music_id: String) -> bool:
	fonte_atual = Fonte.OFFLINE
	emit_signal("fonte_mudou", fonte_atual)

	var item := _get_offline(music_id)
	if item.is_empty():
		return false

	titulo_atual = str(item["titulo"])
	tocando = true

	# Aqui a execução real do áudio será feita por um AudioStreamPlayer
	# (Você conecta isso depois no SistemaAudio / Cena do carro).
	emit_signal("musica_mudou", titulo_atual)
	emit_signal("tocando_mudou", tocando)
	return true

func play_radio(station_id: String) -> bool:
	fonte_atual = Fonte.RADIO
	emit_signal("fonte_mudou", fonte_atual)

	var st := _get_station(station_id)
	if st.is_empty():
		return false

	# Aplica filtro "sem palavrão"
	if filtro == FiltroConteudo.SEM_PALAVRAO and not st.get("tags", []).has("clean"):
		return false

	titulo_atual = "Rádio: " + str(st["nome"])
	tocando = true
	emit_signal("musica_mudou", titulo_atual)
	emit_signal("tocando_mudou", tocando)
	return true

func set_youtube_link(link: String) -> void:
	# Guarda o link e deixa pronto para o jogo abrir externo
	fonte_atual = Fonte.YOUTUBE_LINK
	emit_signal("fonte_mudou", fonte_atual)

	ultimo_youtube_link = link.strip_edges()
	titulo_atual = "YouTube (externo)"
	tocando = true
	emit_signal("musica_mudou", titulo_atual)
	emit_signal("tocando_mudou", tocando)

func pause() -> void:
	tocando = false
	emit_signal("tocando_mudou", tocando)

func stop() -> void:
	tocando = false
	titulo_atual = ""
	emit_signal("tocando_mudou", tocando)
	emit_signal("musica_mudou", titulo_atual)

func listar_offline() -> Array:
	return offline_library

func listar_radio_disponivel() -> Array:
	if filtro == FiltroConteudo.SEM_PALAVRAO:
		var clean: Array = []
		for r in radio_stations:
			if r.get("tags", []).has("clean"):
				clean.append(r)
		return clean
	return radio_stations

func _get_offline(id: String) -> Dictionary:
	for m in offline_library:
		if m["id"] == id:
			return m
	return {}

func _get_station(id: String) -> Dictionary:
	for s in radio_stations:
		if s["id"] == id:
			return s
	return {}

func to_dict() -> Dictionary:
	return {
		"filtro": filtro,
		"fonte_atual": fonte_atual,
		"volume": volume,
		"tocando": tocando,
		"titulo_atual": titulo_atual,
		"ultimo_youtube_link": ultimo_youtube_link,
		"offline_library": offline_library,
		"radio_stations": radio_stations
	}

func from_dict(d: Dictionary) -> void:
	filtro = int(d.get("filtro", filtro))
	fonte_atual = int(d.get("fonte_atual", fonte_atual))
	volume = float(d.get("volume", volume))
	tocando = bool(d.get("tocando", tocando))
	titulo_atual = str(d.get("titulo_atual", titulo_atual))
	ultimo_youtube_link = str(d.get("ultimo_youtube_link", ultimo_youtube_link))
	offline_library = d.get("offline_library", offline_library)
	radio_stations = d.get("radio_stations", radio_stations)
