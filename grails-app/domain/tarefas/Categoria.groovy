package tarefas

class Categoria {

	String nome

	String toString(){
		this.nome
	}
	
    static constraints = {
		nome nullable:false, blank:false, maxSize:128
    }
}
