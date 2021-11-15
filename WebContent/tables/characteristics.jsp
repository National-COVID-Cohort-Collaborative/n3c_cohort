<script>
$.getJSON("feeds/characteristics.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.id="table1";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("table");
	divContainer.innerHTML = "<h3>Patient Characteristics by COVID Status</h3>";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#table1').DataTable( {
    	data: data,
       	paging: false,
    	order: [[0, 'asc'],[1, 'asc']],
     	columns: [
        	{ data: 'variable', visible: true, orderable: true },
        	{ data: 'value', visible: true, orderable: true },
        	{ data: 'x__all', visible: true, orderable: true },
        	{ data: 'no_covid_test', visible: true, orderable: true },
        	{ data: 'suspected_covid', visible: true, orderable: true },
        	{ data: 'lab_confirmed_negative', visible: true, orderable: true },
        	{ data: 'lab_confirmed_positive', visible: true, orderable: true }
    	]
	} );

	
});
</script>
