<script>
$.getJSON("feeds/positive_cases_by_date.jsp?headers=y", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover compact site-wrapper';
	table.style.width = '100%';
	table.id="positives-by-date-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("positives-by-date");
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#positives-by-date-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'first_diagnosis_date', visible: true, orderable: true, className: 'text-center' },
        	{ data: 'positive_cases', visible: true, orderable: true, className: 'text-right' },
        	{ data: 'cumsum_positivecases', visible: true, orderable: true, className: 'text-right' },
        	{ data: 'seven_day_rolling_avg', visible: true, orderable: true, className: 'text-right' }
    	],
    	columnDefs: [
    		{ targets: 1, render: $.fn.dataTable.render.number(',', '.', 0, '') },    		
    		{ targets: 2, render: $.fn.dataTable.render.number(',', '.', 0, '') },    		
    		{ targets: 3, render: $.fn.dataTable.render.number(',', '.', 0, '') },   		
    	]
	} );

	
});
</script>
