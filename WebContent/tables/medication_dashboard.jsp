<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js"></script>
<style>
th.dt-center, td.dt-center { text-align: center; }
</style>
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
            {"label":"", "colspan": 3},
            {"label":"COVID Positive (n = " + $('#positive').text() + ")", "colspan": 4},
        ],
        [
            {"label":"", "colspan": 3},
            {"label":"Any time", "colspan": 1},
            {"label":"Medication prescribed within +/-7 days of Covid Diagnosis", "colspan": 2},
            {"label":"Med Rx -8 days of Dx", "colspan": 1},
        ]
    ];

    var header_row_top, th;
    staticHeaders.forEach(function(headers, index){
        header_row_top = header.insertRow(index);
        headers.forEach(function(header, i) {
            th = document.createElement("th");
                th.innerHTML = '<span style="color:#FFF; font-weight:600; font-size:16px;">' + header.label + '</span>';
                th.setAttribute("colspan", header.colspan);
                if (header.label == "")
                    th.style.border = "0px";
                else
                    th.style.backgroundColor = "#666";
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

	    if (label === "N3C") // append "Persons" value
	        label += "<br/>(N = " + $('#persons').text() + ")";

        var th = document.createElement("th");
        th.innerHTML = '<span style="color:#FFF; font-weight:600; font-size:16px;">' + label + '</span>';
        th.style.backgroundColor = "#666";
        header_row_bottom.appendChild(th);
	}

	var divContainer = document.getElementById("medication-dashboard");
	divContainer.appendChild(table);

	$('#meds_table').DataTable( {
        	data: json['rows'],
           	paging: false,
        	order: [[0, 'asc']],
        	'columnDefs': [{"className": "dt-center", "targets": "_all"}],
         	columns: [
            	{ data: 'class', visible: true, orderable: true },
            	{
            	    data: 'name', visible: true, orderable: true,
            	    render: function (data) {
            	        return data.toLowerCase();
                    }
                },
            	{ data: 'total', visible: true, orderable: true },
            	{ data: 'all__hospitalized_and_not_', visible: true, orderable: true },
            	{
            	    data: 'all__hospitalized_and_not__1', visible: true, orderable: true,
            	    render: function ( data, type, row, meta ) {
                        if (type === 'sort') {
                            return isNaN(row.all__hospitalized_and_not__1) ? 0 : row.all__hospitalized_and_not__1;
                        } else if (type === 'display') {
                            return row.all__hospitalized_and_not__1;
                        } else {
                            return 0;
                        }
                    }
                },
            	{
            	    data: 'hospitalized', visible: true, orderable: true,
            	    render: function ( data, type, row, meta ) {
            	        if (type === 'sort') {
                            return isNaN(row.hospitalized) ? 0 : row.hospitalized;
                        } else if (type === 'display') {
                            return row.hospitalized;
                        } else {
                            return 0;
                        }
            	    }
            	},
            	{
            	    data: 'all__hospitalized_and_not__2', visible: true, orderable: true,
            	    render: function ( data, type, row, meta ) {
            	        var covidAll = row.all__hospitalized_and_not_;
            	        var covid7d = row.all__hospitalized_and_not__1;
            	        var med8 = isNaN(parseInt(covid7d)) ? 0 : (parseInt(covidAll) - parseInt(covid7d));

            	        if (type === 'sort') {
            	            return med8;
                        } else if (type === 'display') {
            	            return med8 > 0 ? med8 : 'N/A';
                        } else {
                            return med8;
                        }
                    }
                 }
        	]
    	} );
});
</script>