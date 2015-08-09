tasksController = function() {
	function errorLogger(errorCode, errorMessage) {
		console.log(errorCode +':'+ errorMessage);
	}
	
	function contador(){
		//conta quantas tarefas podem ser editadas ou seja ainda não foram finalizadas
		var count = $(taskPage).find('.editRow').length;
    	$('footer').find('#taskCount').text(count);
	}
	
	
	var taskPage;
	var initialised = false;   
	return {
		init : function(page, callback) {
				
			if (initialised) {
			
				callback()
			} else{
				taskPage = page;
							
				//campos obrigatorios
				$(taskPage).find( '[required="required"]' ).prev('label').append( '<span>*</span>').children( 'span').addClass('required');
				
				$(taskPage).find('tbody tr:even').addClass( 'even');
				
				//marca a linha destacada
				$(taskPage).find('tbody').on('click','tr',function(evt) {
					$(evt.target).closest('td').siblings().andSelf().toggleClass('rowHighlight');
				});
						
				//adiciona uma tarefa
				$(taskPage).find( '#btnAddTask' ).click( function(evt) {
					evt.preventDefault();
					$(taskPage ).find('#taskCreation' ).removeClass( 'not');
					tasksController.loadTasks();
					contador();
				});
				
				//remove uma tarefa
				$(taskPage).find('#tblTasks tbody').on('click', '.deleteRow', 
					function(evt) { 					
						console.log('teste');
						storageEngine.delete('task', $(evt.target).data().taskId, 
						function() {
							$(evt.target).parents('tr').remove(); 
							tasksController.loadTasks();
							}, errorLogger);
						contador();
				});	
				
				//Completa uma tarefa
        		$(taskPage).find('#tblTasks tbody').on('click', '.completeRow', 
        			function(evt) {           
						storageEngine.findById('task', $(evt.target).data().taskId, function(task) {
						task.complete = true;
            			storageEngine.save('task', task, function() {
              			tasksController.loadTasks();
            			},errorLogger);
          			}, errorLogger);
          			contador();
        		});
				
				//salva uma tarefa
				$(taskPage).find('#saveTask').click(function(evt) {
					evt.preventDefault();
					if ($(taskPage).find('form').valid()) {
						var task = $(taskPage).find('form').toObject();		
						storageEngine.save('task', task, function() {
							$(taskPage).find('#tblTasks tbody').empty();
							tasksController.loadTasks();
							$(':input').val('');
							$(taskPage).find('#taskCreation').addClass('not');
						}, errorLogger);
					}
					contador();
				});
				
				//limpa o form da tarefa
				$(taskPage).find('#clearTask').click(function(evt) {
					$(taskPage).find('#taskForm').next($('input').val(""));           				
				});
				
				//edita uma tarefa
				$(taskPage).find('#tblTasks tbody').on('click', '.editRow', 
					function(evt) { 
						$(taskPage).find('#taskCreation').removeClass('not');
						storageEngine.findById('task', $(evt.target).data().taskId, function(task) {
						$(taskPage).find('form').fromObject(task);
						}, errorLogger);
				});
				
				
				initialised = true;
				
				//inicia o storage
				storageEngine.init(function() {
					storageEngine.initObjectStore('task', function() {
						callback();
					}, errorLogger) 
				}, errorLogger);
									
			}
    	},
    	
    	loadTasks : function() {
    			//encontra todas as tarefas no storage
				storageEngine.findAll('task', function(tasks) {
					console.log('teste');
					$(taskPage).find('#tblTasks tbody').empty();
					//ordena as datas das tarefas
					tasks.sort(function(o1, o2) {
						if (Date.parse(o1.requiredBy) == Date.parse(o2.requiredBy))
							return 0;
						else if(Date.parse(o1.requiredBy) > Date.parse(o2.requiredBy))
								return -1;
								else return 1;		
					});
					
								
					$.each(tasks, function(index, task) {
						//verifica se a tarefa esta completa
						if(!task.complete){
							task.complete = false;	
						}
																							
						$('#taskRow').tmpl(task ).appendTo( $(taskPage ).find( '#tblTasks tbody'));
						
						//avisa quando a tarefa estourou o tempo ou falta pouco tempo
						$.each($(taskPage).find('#tblTasks tbody tr'), function(idx, row) {
							var data = Date.parse($(row).find('[datetime]').text());
							if (data < Date.today()) {
								$(row).addClass("overdue");
							} else if ( (data < (4).days().fromNow())) {
								$(row).addClass("warning");
							}
						});
					});
					contador();
				},errorLogger);
					

					
				
		}
			
	}

}();

