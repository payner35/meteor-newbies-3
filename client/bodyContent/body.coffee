_.extend Template.bodyContent,
	todos : ->
		Todos.find {}, sort: name:1