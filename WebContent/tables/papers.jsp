<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$.getJSON("feeds/papers.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="litcovid_publications";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("publications-div");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#litcovid_publications').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 5,
    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
	       	{ data: 'pmid', visible: true, orderable: true,
        		render: function ( data, type, row ) {
        			return '<a href="https://pubmed.ncbi.nlm.nih.gov/'+ row.pmid + '"><span style="color:#376076";>' + row.pmid + '<\/span></a>';
             		}
        		},
   	       	{ data: 'pmcid', visible: true, orderable: true,
           		render: function ( data, type, row ) {
           			if (row.pmcid == null) return '';
           			return '<a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC'+ row.pmcid + '"><span style="color:#376076";>' + row.pmcid + '<\/span></a>';
                	}
           		},
        	{ data: 'title', orderable: true },
        	{ data: 'journal', orderable: true },
        	{ data: 'volume', orderable: true },
        	{ data: 'issue', orderable: true },
        	{ data: 'published', orderable: true },
        	{ data: 'pages', orderable: true }
    	]
	} );

	
});
</script>
