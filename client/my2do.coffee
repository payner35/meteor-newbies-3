# Define Minimongo collections to match server/publish.js.
Lists = new Meteor.Collection "lists"
Todos = new Meteor.Collection "todos"


Meteor.subscribe "lists", ->
	#if there is no list_id in Session.. lets create one
	if(!Session.get('list_id'))
		list = Lists.findOne {}, sort: name:1 #Get the first item
		if (list)
			Router.setList(list._id)
	return

Meteor.autosubscribe ->
	#autosubscribe set us an automatic subscibe / unsubscribe
	list_id = Session.get("list_id")
	if(list_id)
		#subscriprion is updated when the list_id changes
		Meteor.subscribe "todos", list_id
	return

### Tracking selected list in URL ###

TodosRouter = Backbone.Router.extend
	routes:
		":list_id": "main"
	main: (list_id) ->
		#console.log(list_id)
		Session.set("list_id", list_id)
		return
	setList: (list_id) ->
		#navigate to thisSite.com/list_id
		#this will triger the main route above
		#"true" will update the URL
		this.navigate(list_id, true)
		return

Router = new TodosRouter;

Meteor.startup ->
	Backbone.history.start
		pushState: true
	return
	
