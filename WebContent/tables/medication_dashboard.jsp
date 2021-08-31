<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js"></script>
<script>
$.getJSON("feeds/medication_dashboard.jsp", function(data){

	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}

	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.id="table-meds";

	var header= table.createTHead();

	// Hard Coded top level headers
	var staticHeaders = [
	    [
            {"label":"", "colspan": 3},
            {"label":"COVID Positive Patients", "colspan": 4},
            {"label":"", "colspan":2}
        ],
        [
            {"label":"", "colspan": 3},
            {"label":"Any time", "colspan": 1},
            {"label":"Medication prescribed within +/-7 days of Covid Diagnosis", "colspan": 2},
            {"label":"Med Rx -8 days of Dx", "colspan": 1},
            {"label":"", "colspan":2}
        ]
    ];

    staticHeaders.forEach(function(headers, index){
        var header_row_top = header.insertRow(index);
        headers.forEach(function(header, i) {
            var th = document.createElement("th");
                    th.innerHTML = '<span style="color:#FFF; font-weight:600; font-size:16px;">' + header.label + '</span>';
                    th.setAttribute("colspan", header.colspan);
                    th.style.border = "0px";
                    th.style.textAlign = "center";
                    if (header.label != "")
                        th.style.backgroundColor = "#333";
                    header_row_top.appendChild(th);
         })
     });

    var header_row_bottom = header.insertRow(staticHeaders.length);

	// Auto generate level headers that don't span any rows
	for (i in col) {
        var th = document.createElement("th");
        th.innerHTML = '<span style="color:#FFF; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
        th.style.backgroundColor = "#333";
        header_row_bottom.appendChild(th);
	}

	var divContainer = document.getElementById("medication-dashboard");
	divContainer.appendChild(table);

    var data = json['rows'];
	$('#table-meds').DataTable( {
    		dom: 't',
        	data: data,
           	paging: false,
    	 	bInfo: false,
    	 	searching: false,
        	order: [[5, 'desc']],
         	columns: [
            	{ data: 'class', visible: true, orderable: true },
            	{ data: 'name', visible: true, orderable: true },
            	{ data: 'total', visible: true, orderable: true },
            	{ data: 'covid_positive', visible: true, orderable: true },
            	{ data: 'not_hospitalized', visible: true, orderable: true },
            	{ data: 'hospitalized', visible: true, orderable: true },
            	{ data: 'med_8', visible: true, orderable: true }
        	]
    	} );

});
</script>