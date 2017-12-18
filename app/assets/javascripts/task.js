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
			item_data = item.data();
			params = {
			  _method: 'put'
			};
			params[item_data.modelName] = {
			  row_order_position: item.index()
			};
			$.ajax;
			return {
        type: 'POST',
        url: item_data.updateUrl,
        dataType: 'json',
        data: params
			};
		}
	})
});