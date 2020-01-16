extends Control

signal atualizar_vida(vida)

func _on_Enemigo_atualizar_vida(vida):
	print ("recebeu sinal")
	emit_signal("atualizar_vida", vida)
	pass
