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
	table.id="question-table2";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("question-roster2");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	(async () => {

		const { config, csrfTokenInfo } =  await auth2()
		    
		$('#question-table2').DataTable( {
			"dom": '<lf<t>ip>',
			data: data,
	       	select: true,
	       	paging: true,
	    	pageLength: 10,
	    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
	    	order: [[2, 'desc']],
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
	        			var iframe_content = row.iframe_content;
	        			var iframe_style = row.iframe_style;
	        			var combo = 
	        				'<div class="panel-group" style="margin-bottom:0px;" id="' + iframe.replace(/\s+/g, '').toLowerCase() + '_stub">'
	        					+'<div class="panel panel-default" style="background:none; border:none; box-shadow:none;">'
	        							+'<h5 style="color: #376076;"><a onclick="iframe_render(\''+ config.tenantDomain + '\',\''+ config.appId + '\',\''+ iframe_content + '\',\''+ config.qlikWebIntegrationId + '\',\''+ csrfTokenInfo.headers.get("qlik-csrf-token") + '\',\''+ iframe_style+ '\',\''+ question.replace(/'/g, "\\'") + '\',\''+ desc.replace(/'/g, "\\'") +'\',\''+ asked+ '\',\''+ limitations.replace(/\"/g,"'").replace(/'/g, "\\'").replace(/\r?\n/g,"")+'\');">' + question + '</a></h5>'
	       						+'</div>'
	        				+'</div>';
	             		return combo; }
	             },
	        	{ data: 'description', visible: false },
	        	{ data: 'asked', visible: false },
	        	{ data: 'limitations', visible: false},
	        	{ data: 'iframe_info', visible: false},
	        	{ data: 'iframe_content', visible: false},
	        	{ data: 'iframe_style', visible: false}
	    	]
		} );

	  
	})();
	
});

function iframe_render(tenant, appID, content, integrationID, token, style, question, description, asked, limitations) {
	var divContainer = document.getElementById("question-tile");
	divContainer.innerHTML = 
		'<h2>' + question + '</h2>'
	  +'<p>' + description + '</p>'
	  +'<iframe src="https://'+tenant+'/single/?appid='+appID+'&sheet='+content
	  +'&qlik-web-integration-id='+integrationID
	  +'&qlik-csrf-token='+token+'" style="'+style+'" ></iframe>'
		+'<br><a class="accordion-toggle" data-toggle="collapse" data-parent="#iframe_accordion" href="#iframe_details">Details</a>'
		+'<div id="iframe_accordian">'
			+'<div id="iframe_details" class="panel-body panel-collapse collapse">'
	  			+'<p><strong>Limitations:</strong> ' + limitations + '</p>'
	  		+'</div>'
	  	+'</div>'
;
}
</script>