<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$.getJSON("feeds/questions.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="question-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("question-roster");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#question-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 5,
    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
    	columns: [
        	{ 
        		data: 'qeustion',
        		orderable: false,
        		render: function ( data, type, row ) {
        			var question = row.question;
        			var asked = row.asked;
        			var desc = row.description;
        			var limitations = row.limitations;
        			var iframe = row.iframe_info;
        			var combo = 
        				'<div class="panel-group" style="margin-bottom:0px;" id="' + iframe.replace(/\s+/g, '').toLowerCase() + '_accordion">'
        					+'<div class="panel panel-default" style="background:none; border:none; box-shadow:none;">'
        						+'<div class="panel-heading" style="background:none; text-align:left;">'
        							+'<a class="accordion-toggle" data-toggle="collapse" data-parent="#' + iframe.replace(/\s+/g, '').toLowerCase() + '_accordion" href="#'	+ iframe.replace(/\s+/g, '').toLowerCase() + '_description">' + question + '</a>'
           						+'</div>'
        						+'<div class="panel-body" style="border:none;">'
        							+ asked + '<br>' + desc
               					+'</div>'
        						+'<div id="' + iframe.replace(/\s+/g, '').toLowerCase() + '_description" class="panel-body panel-collapse collapse">'
        							+ '<strong>IFrame:</strong> ' + iframe+ '<br><br><strong>Limitations:</strong> ' + limitations 
        						+'</div>'
       						+'</div>'
        				+'</div>';
             		return combo; }
             },
        	{ data: 'description', visible: false },
        	{ data: 'asked', visible: false },
        	{ data: 'limitations', visible: false},
        	{ data: 'iframe_info', visible: false}
    	]
	} );

	
});
</script>