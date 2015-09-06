// create local db
this.db = new localStorageDB("db", localStorage);

// do something if db doesn't exist
if (db.isNew()) {

	// create a task table
	db.createTable("tasks", ["content", "createdAt", "completed"]);

	// add some random data
	db.insert("tasks", {
		content: 'this is your first task, check it to complete',
		createdAt: Date.now(),
		completed: false
	});

	// commit changes
	db.commit();

}

// mount layout
riot.mount("layout");

// vendors configuration
moment.locale('zh-CN');
