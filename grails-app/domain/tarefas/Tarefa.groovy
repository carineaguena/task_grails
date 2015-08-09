package tarefas

class Tarefa {
	
	String descricao
	Date data
	boolean complete
	
	static belongsTo = [categoria:Categoria]
	
    static constraints = {
		descricao nullable:false, blank:false, maxSize:128
		data nullable:false, blank:false
		complete nullable:false
		categoria nullable:false
    }
}
