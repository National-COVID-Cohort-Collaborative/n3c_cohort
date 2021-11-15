<script>
$.getJSON("feeds/severity.jsp", function(data){
		
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
	divContainer.innerHTML = "<h3>Severity</h3>";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#table1').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc'],[1, 'asc']],
     	columns: [
        	{ data: 'variable', visible: true, orderable: true },
        	{ data: 'value', visible: true, orderable: true },
        	{ data: 'x__all', visible: true, orderable: true },
        	{ data: 'mild', visible: true, orderable: true },
        	{ data: 'mild_ed', visible: true, orderable: true },
        	{ data: 'moderate', visible: true, orderable: true },
        	{ data: 'severe', visible: true, orderable: true },
        	{ data: 'dead_w_covid', visible: true, orderable: true }
    	]
	} );

	
});
</script>
