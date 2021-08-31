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
	var header_row_top = header.insertRow(0); 
	var header_row_bottom = header.insertRow(1); 
	
	// Hard Coded top level headers
	var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;"> </span>';
		th.setAttribute("colspan", "1");
		th.style.border = "0px";
		th.style.textAlign = "center";
		header_row_top.appendChild(th);
	
	var th = document.createElement("th");
		//th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[1].toString() +  '</span>';
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;"> All COVID+ </span>';
		th.setAttribute("colspan", "1");
		th.setAttribute("rowspan", "2");
		th.style.textAlign = "center";
		header_row_top.appendChild(th);
	
	var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;"> Mild </span>';
		th.setAttribute("colspan", "2");
		th.style.textAlign = "center";
		header_row_top.appendChild(th);
		
	var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;"> Hospitalized </span>';
		th.setAttribute("colspan", "3");
		th.style.textAlign = "center";
		header_row_top.appendChild(th);
		
	// Auto generate 2nd level headers that don't span 2 rows
	for (i in col) {
		// x__all spans two rows so it is hard coded above and shouldn't be displayed
		if (col[i] != "All"){
			var th = document.createElement("th");
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
			header_row_bottom.appendChild(th);
		}
	}
	
	var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">Dummy All Hospitalized</span>';
		header_row_bottom.appendChild(th);
	
	// Hard coded Footer. If we sort these values in query as column order we could just do what we do for auto header above
	var footer = table.createTFoot();
	var footer_row = footer.insertRow(0); 
	

	var td = document.createElement("td");
		td.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + json['rows'][json['rows'].length-1]['value'].toString() + '</span>';
		footer_row.appendChild(td);
	var td = document.createElement("td");
		td.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + json['rows'][json['rows'].length-1]['x__all'].toString() + '</span>';
		footer_row.appendChild(td);
	var td = document.createElement("td");
		td.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + json['rows'][json['rows'].length-1]['mild'].toString() + '</span>';
		footer_row.appendChild(td);
	var td = document.createElement("td");
		td.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + json['rows'][json['rows'].length-1]['mild_ed'].toString() + '</span>';
		footer_row.appendChild(td);
	var td = document.createElement("td");
		td.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + json['rows'][json['rows'].length-1]['moderate'].toString() + '</span>';
		footer_row.appendChild(td);
	var td = document.createElement("td");
		td.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + json['rows'][json['rows'].length-1]['severe'].toString() + '</span>';
		footer_row.appendChild(td);
	var td = document.createElement("td");
		td.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + json['rows'][json['rows'].length-1]['dead_w_covid'].toString() + '</span>';
		footer_row.appendChild(td);
	var td = document.createElement("td");
		td.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;"> Dummy (N= ?)</span>';
		footer_row.appendChild(td);

	

	var divContainer = document.getElementById("charlson-dashboard");
	divContainer.appendChild(table);

	
	var data = json['rows'];
		// drop last row of totals b/c represented as a footer
		data.splice(-1, 1);
		
	//populate all hospitalized with dummy values
	for (i in data){
		data[i].hospital_total = "5";
	}
	

	$('#table1').DataTable( {
		dom: 't',
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
        	{ data: 'dead_w_covid', visible: true, orderable: true },
        	{ data: 'hospital_total', visible: true, orderable:true }
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
