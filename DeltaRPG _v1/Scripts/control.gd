extends Control

signal pergunta_finalizada(sucesso: bool)

var lista_numeros: Array = []
var etapa: int = 0
var resposta_correta: int = 0
var acertos: int = 0

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	visible = false

func configurar(lista: Array):
	lista_numeros = lista
	etapa = 0
	acertos = 0
	gerar_pergunta()

func gerar_pergunta():
	var texto_pergunta = ""
	var valor_correto = 0
	
	match etapa:
		0:
			texto_pergunta = "Qual é a média dos números?"
			valor_correto = calcular_media(lista_numeros)
		1:
			texto_pergunta = "Qual é a mediana dos números?"
			valor_correto = calcular_mediana(lista_numeros)
		2:
			texto_pergunta = "Qual é a moda dos números?"
			valor_correto = calcular_moda(lista_numeros)
			
	resposta_correta = valor_correto
	
	var alternativas = gerar_alternativas(valor_correto)
	
	$Panel/NinePatchRect/Label.text = texto_pergunta
	
	var container = $Panel/NinePatchRect/VBoxContainer
	for i in container.get_children():
		i.queue_free()
		
	for alt in alternativas:
		var botao = Button.new()
		botao.text = str(alt)
		botao.pressed.connect(_on_resposta.bind(alt))
		container.add_child(botao)
		
func _on_resposta(resposta: int):
	if resposta == resposta_correta:
		$Panel/NinePatchRect/Label2.text = "Correto!"
		acertos += 1
	else:
		$Panel/NinePatchRect/Label2.text = "Errado. Resposta correta: " + str(resposta_correta)
	
	await get_tree().create_timer(2.0).timeout
	
	etapa += 1
	if etapa > 2:
		var gabaritou = acertos == 3
		$Panel/NinePatchRect/Label.text = "Missão concluída! Dirija-se ao delta."
		$Panel/NinePatchRect/VBoxContainer.queue_free()
		$Panel/NinePatchRect/Label3.queue_free()
		$Panel/NinePatchRect/Label2.queue_free()
		await get_tree().create_timer(3.0).timeout
		emit_signal("pergunta_finalizada", gabaritou)
		$"../../Macyrajara".visible = true
		fechar()
	else:
		gerar_pergunta()

func abrir_com_perguntas(valores: Array):
	get_tree().paused = true
	visible = true
	configurar(valores)

func fechar():
	get_tree().paused = false
	visible = false

func calcular_media(lista: Array) -> int:
	if lista.is_empty():
		return 0
	var soma = 0
	for n in lista:
		soma += n
	return round(soma / lista.size())

func calcular_mediana(lista: Array) -> int:
	if lista.is_empty():
		return 0
	
	var ordenada = lista.duplicate()
	ordenada.sort()
	var meio = ordenada.size() / 2
	
	if ordenada.size() % 2 == 0:
		return round((ordenada[int(meio) - 1] + ordenada[int(meio)]) / 2.0)
	else:
		return ordenada[int(meio)]

func calcular_moda(lista: Array) -> int:
	if lista.is_empty():
		return 0
	
	var contador = {}
	for n in lista:
		if n in contador:
			contador[n] += 1
		else:
			contador[n] = 1
	
	var moda = lista[0]
	var max_count = contador[moda]
	
	for chave in contador.keys():
		if contador[chave] > max_count:
			moda = chave
			max_count = contador[chave]
	
	return moda

func gerar_alternativas(correta: int) -> Array:
	var alternativas = [correta]
	
	while alternativas.size() < 4:
		var aleatorio = correta + randi_range(-10, 10)
		
		if aleatorio == correta or aleatorio < 0:
			continue
			
		if not alternativas.has(aleatorio):
			alternativas.append(aleatorio)
	
	alternativas.shuffle()
	return alternativas
