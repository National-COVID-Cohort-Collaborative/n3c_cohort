<script>
var aggregated_datatable = null;

$.getJSON("feeds/aggregated.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover compact site-wrapper';
	table.style.width = '100%';
	table.id="aggregated-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("aggregated");
	divContainer.appendChild(table);

	var data = json['rows'];

	aggregated_datatable = $('#aggregated-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'race', visible: true, orderable: true },
        	{ data: 'ethnicity', visible: true, orderable: true },
        	{ data: 'age_bin', visible: true, orderable: true },
        	{ data: 'gender', visible: true, orderable: true },
        	{ data: 'severity', visible: true, orderable: true },
        	{ data: 'patient_count', visible: true, orderable: true }
    	]
	} );

	
});
</script>
