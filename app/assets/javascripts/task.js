$(document).ready(function(){
	$("#calendar").fullCalendar({
		events: '/user/tasks_for_calendar.json'
	})
});