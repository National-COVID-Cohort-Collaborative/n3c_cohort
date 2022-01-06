<script>
$.getJSON("feeds/siteRoster.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover compact site-wrapper';
	table.style.width = '100%';
	table.id="site-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("site-roster");
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#site-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'site', visible: true, orderable: true,
        		render: function ( data, type, row ) {
        			return '<a href="'+ row.url + '"><span style="color:#376076";>' + row.site + '<\/span></a>';
             		}
        		},
        	{ data: 'type', visible: true, orderable: true },
        	{ data: 'data_model', visible: true, orderable: true },
        	{ data: 'status', visible: true, orderable: true }
    	]
	} );

	
});
</script>
