<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js"></script>
<script>
$.getJSON("feeds/charlson_dashboard.jsp", function(data){
		
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

	var divContainer = document.getElementById("charlson-dashboard");
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#table1').DataTable( {
    	data: data,
       	paging: false,
	 	bInfo: false,
	 	searching: false,
    	order: [[0, 'asc'],[1, 'asc']],
     	columns: [
        	{ data: 'value', visible: true, orderable: true },
        	{ data: 'x__all', visible: true, orderable: true },
        	{ data: 'mild', visible: true, orderable: true },
        	{ data: 'mild_ed', visible: true, orderable: true },
        	{ data: 'moderate', visible: true, orderable: true },
        	{ data: 'severe', visible: true, orderable: true },
        	{ data: 'dead_w_covid', visible: true, orderable: true }
    	]
	} );

	
	$("#table1 td").hottie({
	    colorArray : [ 
	        "#fffcf7",
	        "#f69035"
	        // add as many colors as you like...
	    ]
	});
	
});
</script>
