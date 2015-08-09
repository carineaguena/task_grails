<%@ page import="tarefas.Tarefa" %>



<div class="fieldcontain ${hasErrors(bean: tarefaInstance, field: 'descricao', 'error')} required">
	<label for="descricao">
		<g:message code="tarefa.descricao.label" default="Descricao" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descricao" maxlength="128" required="" value="${tarefaInstance?.descricao}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: tarefaInstance, field: 'data', 'error')} required">
	<label for="data">
		<g:message code="tarefa.data.label" default="Data" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="data" precision="day"  value="${tarefaInstance?.data}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: tarefaInstance, field: 'complete', 'error')} ">
	<label for="complete">
		<g:message code="tarefa.complete.label" default="Complete" />
		
	</label>
	<g:checkBox name="complete" value="${tarefaInstance?.complete}" />

</div>

<div class="fieldcontain ${hasErrors(bean: tarefaInstance, field: 'categoria', 'error')} required">
	<label for="categoria">
		<g:message code="tarefa.categoria.label" default="Categoria" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="categoria" name="categoria.id" from="${tarefas.Categoria.list()}" optionKey="id" required="" value="${tarefaInstance?.categoria?.id}" class="many-to-one"/>

</div>

