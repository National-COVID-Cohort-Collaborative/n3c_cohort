<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>
<style>
th.dt-center, td.dt-center { text-align: center; }
</style>
<script>
$.getJSON("feeds/vaccine.jsp", function(data){

	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}

	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.id="vaccine_table";

	var header= table.createTHead(),
	    header_row_top = header.insertRow(0);

	// Build the headers
	for (i in col) {
	    label = col[i].toString();

	    if (label == "Description")
	        continue;

        var th = document.createElement("th");
        th.innerHTML = '<span style="color:#FFF; font-weight:600; font-size:16px;">' + label + '</span>';
        th.style.backgroundColor = "#666";
        header_row_top.appendChild(th);
	}

	var divContainer = document.getElementById("vaccine-dashboard");
	divContainer.appendChild(table);

	$('#vaccine_table').DataTable( {
        data: json['rows'],
        paging: false,
        bInfo: false,
        searching: false,
        order: [[1, 'desc']],
        'columnDefs': [{"className": "dt-center", "targets": "_all"}],
        columns: [
            { data: 'common_name', visible: true, orderable: false },
            { data: 'count', visible: true, orderable: false }
        ]
    } );
});
</script>