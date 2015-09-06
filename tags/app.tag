<!-- layout -->
<layout>
	<todos></todos>
</layout>

<!-- todos -->
<todos>

	<form onsubmit="{submitTask}">
		<input type="text" placeholder="输入任务细节" required>
		<input type="submit" value="提交">
	</form>

	<div class="ui-flex-column">
		<label each={tasks} onclick="{completeTask}" class="ui-flex-row ui-padded bordered-bottom module" style="padding-left: 32px;">
			<input type="checkbox" style="position: relative; left: -8px; top: 3px;">
			<span>{content} · <small class="text-mute">{fromNow(createdAt)}</small></span>
		</label>
	</div>

	<script>
		// bind this
		var self = this;

		// sort options
		var __defaultQueryOptions = {
			query: { completed: false },
			sort: [["createdAt", "DESC"]]
		}

		// fetch all tasks
		this.tasks = db.queryAll("tasks", __defaultQueryOptions);

		// submit task
		submitTask(e) {
			// prevent form default event
			e.preventDefault();

			// insert your task to localStorage
			var task = {
				content: e.target[0].value,
				createdAt: Date.now(),
				completed: false
			}

			// flush to get changes
			db.insert("tasks", task);
			self.flush();

			// reset form
			$(e.target).trigger('reset');
		}

		// complete a task
		completeTask(e) {
			db.update("tasks", { ID: e.item.ID }, function(task) {
				task.completed = true;
				return task;
			});
			self.flush();
		}

		// get changes from db
		flush() {
			self.tasks = db.queryAll("tasks", __defaultQueryOptions);
			db.commit();
		}

		// date from now
		fromNow(date) {
			return moment(date).fromNow();
		}
	</script>

</todos>
