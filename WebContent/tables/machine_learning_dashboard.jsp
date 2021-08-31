<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js"></script>
<script>
$.getJSON("feeds/machine_learning_dashboard.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.id="ml_table";

	var header= table.createTHead();
	var header_row_top = header.insertRow(0); 
	var header_row_bottom = header.insertRow(1); 
	
	// Hard Coded top level headers
	var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;"> </span>';
		th.setAttribute("colspan", "3");
		th.style.border = "0px";
		th.style.textAlign = "center";
		header_row_top.appendChild(th);
	
	var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;"> Logistic Regression </span>';
		th.setAttribute("colspan", "4");
		th.style.textAlign = "center";
		header_row_top.appendChild(th);
		
	var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;"> </span>';
		th.setAttribute("colspan", "2");
		th.style.border = "0px";
		th.style.textAlign = "center";
		header_row_top.appendChild(th);
		
	// Auto generate 2nd level headers that don't span 2 rows
	for (i in col) {
			var th = document.createElement("th");
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
			header_row_bottom.appendChild(th);
	}
	
	
	var divContainer = document.getElementById("machine-learning-dashboard");
	divContainer.appendChild(table);


		
	$('#ml_table').DataTable( {
    	data: json['rows'],
       	paging: false,
	 	order: [[8, 'asc']],
	 	searchable: true,
     	columns: [
        	{ data: 'variable', visible: true, orderable: true},
        	{ data: 'randomforest_feature_rank', visible: true, orderable: true },
        	{ data: 'xgboost_feature_rank', visible: true, orderable: true },
        	{ data: 'logisticregression_none_feature_rank', visible: true, orderable: true },
        	{ data: 'logisticregression_l2_feature_rank', visible: true, orderable: true },
        	{ data: 'logisticregression_l2_feature_rank', visible: true, orderable: true },
        	{ data: 'logisticregression_elasticnet_feature_rank', visible: true, orderable: true },
        	{ data: 'ridgeclassifier_feature_rank', visible: true, orderable: true },
        	{ data: 'mean', visible: true, orderable: true }
    	]	
	} );

	
	$("#ml_table td").hottie({
	    colorArray : [ 
	    	"#2d5985",
	        "#bce4d8"
	        // add as many colors as you like...
	    ]
	});
	
});
</script>