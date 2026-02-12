extends Node
class_name AppSomRadio

# Este script é a lógica do app.
# A UI (botões/listas) você conecta depois.

var midia: SistemaMidia

func configurar(_midia: SistemaMidia) -> void:
	midia = _midia

func tocar_radio_clean() -> void:
	if midia == null:
		return
	var lista := midia.listar_radio_disponivel()
	if lista.size() > 0:
		midia.play_radio(str(lista[0]["id"]))

func tocar_offline_primeira() -> void:
	if midia == null:
		return
	var lista := midia.listar_offline()
	if lista.size() > 0:
		midia.play_offline(str(lista[0]["id"]))

func colar_link_youtube(link: String) -> void:
	if midia == null:
		return
	midia.set_youtube_link(link)

func pausar() -> void:
	if midia: midia.pause()

func parar() -> void:
	if midia: midia.stop()

func set_volume(v: float) -> void:
	if midia: midia.set_volume(v)

func set_sem_palavrao(ativo: bool) -> void:
	if midia == null:
		return
	midia.set_filtro(SistemaMidia.FiltroConteudo.SEM_PALAVRAO if ativo else SistemaMidia.FiltroConteudo.LIVRE)
