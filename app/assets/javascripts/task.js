$(document).ready(function(){
	$("#calendar").fullCalendar({
		events: '/user/tasks_for_calendar.json'
	})

	$(".table-sortable").sortable({
		axis: 'y',
		items: '.item',
		update: function(e, ui) {
			var item, item_data, params;
			item = ui.item;
			item_data = item.data('target');
			params = {
			  _method: 'patch'
			};
			params[item_data.model_name] = {
			  row_order_position: item.index()
			};
			$.ajax ({
        type: 'POST',
        url: item_data.update_url,
        dataType: 'json',
        data: params
			});
		}
	})
});