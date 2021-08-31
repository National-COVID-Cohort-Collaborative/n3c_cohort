<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js"></script>
<script>
$.getJSON("feeds/meds_by_class.jsp", function(data){

	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}

	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.id="meds_table";

	var header= table.createTHead();

	// Hard Coded top level headers
	var staticHeaders = [
	    [
            {"label":"", "colspan": 1},
            {"label":"COVID Positive Patients", "colspan": 4},
            {"label":"", "colspan":2}
        ],
        [
            {"label":"", "colspan": 1},
            {"label":"Any time", "colspan": 1},
            {"label":"Medication prescribed within +/-7 days of Covid Diagnosis", "colspan": 2},
            {"label":"Med Rx -8 days of Dx", "colspan": 1},
            {"label":"", "colspan":2}
        ]
    ];

    var header_row_top, th;
    staticHeaders.forEach(function(headers, index){
        header_row_top = header.insertRow(index);
        headers.forEach(function(header, i) {
            th = document.createElement("th");
                th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + header.label + '</span>';
                th.setAttribute("colspan", header.colspan);
                if (header.label == "")
                    th.style.border = "0px";
                th.style.textAlign = "center";
                header_row_top.appendChild(th);
         })
     });

    var header_row_bottom = header.insertRow(staticHeaders.length);

	// Auto generate level headers that don't span any rows
	var label;
	for (i in col) {
	    label = col[i].toString();
	    if (label == "Age" || label == "Trend") // skip age and trend for now
	        continue;
        var th = document.createElement("th");
        th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + label + '</span>';
        header_row_bottom.appendChild(th);
	}

	var divContainer = document.getElementById("medication-dashboard");
	divContainer.appendChild(table);

	$('#meds_table').DataTable( {
        	data: json['rows'],
           	paging: false,
        	order: [[5, 'desc']],
         	columns: [
            	{ data: 'class', visible: true, orderable: true },
            	{ data: 'name', visible: true, orderable: true },
            	{ data: 'total', visible: true, orderable: true },
            	{ data: 'all__hospitalized_and_not_', visible: true, orderable: true },
            	{ data: 'all__hospitalized_and_not__1', visible: true, orderable: true },
            	{ data: 'hospitalized', visible: true, orderable: true },
            	{ data: 'all__hospitalized_and_not__2', visible: true, orderable: true }
        	]
    	} );
});
</script>