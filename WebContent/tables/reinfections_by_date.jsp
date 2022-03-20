<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<script>

var constraint_begin = null,
constraint_end = null;

function constraint(begin, end) {
	console.log("constraint", begin, end)
	constraint_begin = begin;
	constraint_end = end;
	var table = $('#reinfections-by-date-table').DataTable();
	table.draw();
	updateKPI(table, 'first_diagnosis')
	updateKPI(table, 'reinfected')
}

function updateKPI(table, column) {
	var sum_string = '';
	var sum = table.rows({search:'applied'}).data().pluck(column).sum();
	console.log(sum, table.rows({search:'applied'}).data().pluck(column))
	if (sum < 1000) {
		sumString = sum+'';
	} else if (sum < 1000000) {
		sum = sum / 1000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "k"
	} else {
		sum = sum / 1000000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "M"
		
	}
	console.log(column, sumString)
	document.getElementById(column+'_kpi').innerHTML = sumString
}

jQuery.fn.dataTable.Api.register( 'sum()', function ( ) {
	return this.flatten().reduce( function ( a, b ) {
		if ( typeof a === 'string' ) {
			a = a.replace(/[^\d.-]/g, '') * 1;
		}
		if ( typeof b === 'string' ) {
			b = b.replace(/[^\d.-]/g, '') * 1;
		}

		return a + b;
	}, 0 );
} );

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
		 
	$.getJSON("<util:applicationRoot/>/feeds/reinfections_by_date.jsp?headers=y", function(data){
			
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
		
		
		$.fn.dataTable.moment('MM/DD/YYYY');
	
		$('#reinfections-by-date-table').DataTable( {
	    	data: data,
	       	paging: true,
	    	pageLength: 10,
	    	lengthMenu: [ 10, 25, 50, 75, 100 ],
	    	order: [[0, 'asc']],
	     	columns: [
	        	{ data: 'c_date_display', visible: true, orderable: true, className: 'text-center' },
	        	{ data: 'first_diagnosis_display', visible: true, orderable: true, className: 'text-right' },
	        	{ data: 'reinfected_display', visible: true, orderable: true, className: 'text-right' },
	        	{ data: 'subsequent_test_display', visible: true, orderable: true, className: 'text-right' },
	        	{ data: 'c_date', visible: false, orderable: true, className: 'text-center' },
	        	{ data: 'first_diagnosis', visible: false, orderable: true, className: 'text-right' },
	        	{ data: 'reinfected', visible: false, orderable: true, className: 'text-right' },
	        	{ data: 'subsequent_test', visible: false, orderable: true, className: 'text-right' }
	    	],
	    	columnDefs: [
	    		{ targets: 0, "width": "30%"},
	    		{ targets: 1, render: $.fn.dataTable.render.number(',', '.', 0, '') },    		
	    		{ targets: 2, render: $.fn.dataTable.render.number(',', '.', 0, '') },    		
	    		{ targets: 3, render: $.fn.dataTable.render.number(',', '.', 0, '') },   		
	    	]
		} );
	
		
	});
});


</script>
