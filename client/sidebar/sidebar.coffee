_.extend Template.side,
	lists: ->
		Lists.find {}, sort: name:1
		
	events:
		"keyup #new-list": (event) ->
			if event.which is 13 #enter key
				newList = $("#new-list").val()
				id = Lists.insert({name: newList})
				Router.setList(id);
				event.target.value = ""
			return
		"click .btn-primary": ->
			#kill the list in session.. the selected list
			Lists.remove(Session.get("list_id"))
			$('#deleteListModal').modal('hide')
			return
	
_.extend Template.listItem,
	events:
		"click": ->
			Router.setList(@._id);
			return
		

_.extend Template.listItem.active = ->
	#sets the li class to "active"
	if Session.equals("list_id", @._id) then "active" else ""