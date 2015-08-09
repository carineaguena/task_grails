<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Tarefas</title>
		<meta name="layout" content="main">
		
</head>
<body>
	<header>
		<span>Lista de Tarefas</span>
	</header>
	<main id="taskPage">
		<section id="taskCreation" class="not">
			<form id="taskForm">
				<div>
					<label>Tarefa</label> 
					<input type="text" required="required" name="task" class="large" maxlength="200" placeholder="Estudar e programar" />
				</div>
				<div>
					<label>Finalizar até</label> <input type="date" required="required" name="requiredBy" />
				</div>
				<div>
					<label>Categoria</label> 
					<select name="category">
						<option value="Pessoal">Pessoal</option>
						<option value="Profissional">Profissional</option>
					</select>
				</div>
				<input type="hidden" name="id" />
				<input type="hidden" name="complete" />
				<nav>
					<a href="#" id="saveTask">Salvar tarefa</a>
					<a href="#" id="clearTask">Limpar tarefa</a>
				</nav>
			</form>
		</section>
		<section>
			<table id="tblTasks">
				<colgroup>
					<col width="40%">
					<col width="15%">
					<col width="15%">
					<col width="30%">
				</colgroup>

				<thead>
					<tr>
						<th>Nome</th>
						<th>Deadline</th>
						<th>Categoria</th>
						<th>Ações</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Devolver livros emprestados</td>
						<td><time datetime="2015-10-14" class="datetime">2015-10-14</time></td>
						<td>Pessoal</td>
						<td>
							<nav>
								<a href="#" class="editRow" data-task-id="123">Editar</a>
								<a href="#" class="completeRow" data-task-id="123">Completar</a>
								<a href="#" class="deleteRow" data-task-id="123">Deletar</a>
							</nav>
						</td>
					</tr>

					<tr class="even">
						<td>Apresentar projeto para os clientes</td>
						<td><time datetime="2015-10-14" class="datetime">2015-10-14</time></td>
						<td>Profissional</td>
						<td>
							<nav>
								<a href="#" class="editRow" data-task-id="1234">Editar</a>
								<a href="#" class="completeRow" data-task-id="1234">Completar</a>
								<a href="#" class="deleteRow" data-task-id="1234">Deletar</a>
							</nav>
						</td>
					</tr>

					<tr>
						<td>Encontrar o pessoal para happy hour</td>
						<td><time datetime="2015-10-14" class="datetime">2015-10-14</time></td>
						<td>Pessoal</td>
						<td>
							<nav>
								<a href="#" class="editRow" data-task-id="12345">Editar</a>
								<a href="#" class="completeRow" data-task-id="12345">Completar</a>
								<a href="#" class="deleteRow" data-task-id="12345">Deletar</a>
							</nav>
						</td>
					</tr>
					
				</tbody>
			</table>
			<nav>
				<a href="#" id="btnAddTask">Adicionar tarefa</a>
			</nav>
		</section>
	</main>
	<footer>Você tem <span id="taskCount"></span> tarefas</footer>

<script>
$(document).ready(function() {
	tasksController.init($('#taskPage'));
	tasksController.loadTasks();
	});	
</script>


<script id="taskRow" type="text/x-jQuery-tmpl">
<tr id="{{= id}}">
	<td {{if complete == true}} class="taskCompleted" {{/if}}>{{= task }}</td>
	<td {{if complete == true}} class="taskCompleted" {{/if}}><time datetime="{{= requiredBy}}"> {{= requiredBy}}</time></td>
	<td {{if complete == true}} class="taskCompleted" {{/if}}>{{= category}}</td>
	<td>
		<nav>
			{{if complete != true}}
				<a href="#" class="editRow" data-task-id="{{= id}}">Editar</a>
				<a href="#" class="completeRow" data-task-id="{{= id}}">Completar</a>
			{{/if}}	
				<a href="#" class="deleteRow" data-task-id="{{= id}}">Deletar</a>
		</nav>
	</td>
</tr>
</script>
</body>
</html>
