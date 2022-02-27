<script>

var constraint_begin = null,
constraint_end = null;

function constraint(begin, end) {
	console.log("constraint", begin, end)
	constraint_begin = begin;
	constraint_end = end;
	var table = $('#reinfections-by-date-table').DataTable();
	table.draw();
}

$(document).ready( function () {
	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		    	if (constraint_begin == null)
		    		return true;
		    	if (constraint_begin <= searchData[0] && searchData[0] <= constraint_end)
		    		return true;
		    	
		    	return false;
		    }
		);
		 
	$.getJSON("feeds/reinfections_by_date.jsp?headers=y", function(data){
			
		var json = $.parseJSON(JSON.stringify(data));
	
		var col = [];
	
		for (i in json['headers']){
			col.push(json['headers'][i]['label']);
		}
	
	
		var table = document.createElement("table");
		table.className = 'table table-hover compact site-wrapper';
		table.style.width = '100%';
		table.id="reinfections-by-date-table";
	
		var header= table.createTHead();
		var header_row = header.insertRow(0); 
	
		for (i in col) {
			var th = document.createElement("th");
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
			header_row.appendChild(th);
		}
	
		var divContainer = document.getElementById("reinfections-by-date");
		divContainer.appendChild(table);
	
		var data = json['rows'];
	
		$('#reinfections-by-date-table').DataTable( {
	    	data: data,
	       	paging: true,
	    	pageLength: 10,
	    	lengthMenu: [ 10, 25, 50, 75, 100 ],
	    	order: [[0, 'asc']],
	     	columns: [
	        	{ data: 'c_date', visible: true, orderable: true, className: 'text-center' },
	        	{ data: 'first_diagnosis', visible: true, orderable: true, className: 'text-right' },
	        	{ data: 'reinfected', visible: true, orderable: true, className: 'text-right' },
	        	{ data: 'subsequent_test', visible: true, orderable: true, className: 'text-right' }
	    	],
	    	columnDefs: [
	    		{ targets: 1, render: $.fn.dataTable.render.number(',', '.', 0, '') },    		
	    		{ targets: 2, render: $.fn.dataTable.render.number(',', '.', 0, '') },    		
	    		{ targets: 3, render: $.fn.dataTable.render.number(',', '.', 0, '') },   		
	    	]
		} );
	
		
	});
});

</script>
