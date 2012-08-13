# if the database is empty on server start, create some sample data.
if Meteor.is_server
	Meteor.startup ->
		if Lists.find().count() is 0
			data = [{
				name: "Gavin Payne"
				contents: [
				    ["Data on the Wire", "Simplicity", "Better UX"],
					["One Language", "Simplicity", "Fun"],
					["Database Everywhere", "Simplicity"],
					["Latency Compensation", "Better UX"],
					["Full Stack Reactivity", "Better UX", "Fun"],
					["Embrace the Ecosystem", "Fun"],
					["Simplicity Equals Productivity", "Simplicity", "Fun"]
				]		
				},

				{
					name: "Favorite Scientists"
					contents: [
					   	["Lisp", "GC"],
				         ["C", "Linked"],
				         ["C++", "Objects", "Linked"],
				         ["Python", "GC", "Objects"],
				         ["Ruby", "GC", "Objects"],
				         ["JavaScript", "GC", "Objects"],
				         ["Scala", "GC", "Objects"],
				         ["Erlang", "GC"],
				         ["6502 Assembly", "Linked"]
				         ]
				},	
			]
					
			timestamp = new Date().getTime()
			
			for item in data
				timestamp++
				list_id = Lists.insert ({name: item.name})
				content = item.contents
				
				Todos.insert({
					list_id: list_id
					text: content[0]
					timestamp: timestamp
					tags: content[1..]	
				})
		return