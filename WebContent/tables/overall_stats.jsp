<script>
$.getJSON("feeds/fact_sheet.jsp", function(data){
		
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

	var divContainer = document.getElementById("overall_stats");
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#table1').DataTable( {
    	data: data,
    	bInfo: false,
    	searching: false,
       	paging: false,
    	order: [[0, 'asc'],[1, 'asc']],
     	columns: [
        	{ data: 'title', visible: true, orderable: true },
        	{ data: 'value', visible: true, orderable: true }
    	]
	} );

	
});
</script>
