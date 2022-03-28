<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
	#question-table3 a {
    	cursor: pointer;
	}
	
	#question-roster3 thead{
		display:none;
	}
	#question-roster3 .dataTables_filter{
		float:none;
		text-align:center;
	}
	#question-button{
		display:flex;
	}
	#question-panel{
		border: none;
    	box-shadow: none;
    	-webkit-box-shadow: none;
	}
	#question-button .dropdown-menu{
        height:300px;
        overflow-y:auto;
        width:100%;
    }
    
    .btn-secondary,
	.btn-secondary:visited{
    	background-color: white;
		color: #337ab7;
		border-color: #337ab7;
	}
	
	.btn-secondary:hover,
	.btn-secondary:active,
	.btn-secondary:focus{
		background-color: #337ab7;
    	border-color: #337ab7;
    	color:white;
	}
	
.cards tbody tr {
	float: left;
	width: 100%;
	margin: 0.5rem;
	border: 0.0625rem solid rgba(0, 0, 0, .125);
	border-radius: .25rem;
	box-shadow: 0.25rem 0.25rem 0.5rem rgba(0, 0, 0, 0.25);
}

.cards tbody td {
	display: block;
}

.cards thead {
	display: none;
}

.cards td:before {
	content: attr(data-label);
	display: inline;
	position: relative;
	font-size: 85%;
	top: -0.5rem;
	float: left;
	color: #808080;
	min-width: 4rem;
	margin-left: 0;
	margin-right: 1rem;
	text-align: left;
}
</style>
<script>
$.getJSON("<util:applicationRoot/>/feeds/questions.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}
	
	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="question-table3";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("question-roster3");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	(async () => {

		const { config, csrfTokenInfo } =  await auth2()
		    
		$('#question-table3').addClass("cards");
		$('#question-table3').DataTable( {
			"dom": '<lf<t>ip>',
			data: data,
	       	select: true,
	       	paging: false,
	       	searching: false,
	       	bInfo : false,
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
	        							+'<a onclick="changeclick.call(); iframe_render(\''+ config.tenantDomain + '\',\''+ config.appId + '\',\''+ iframe_content + '\',\''+ config.qlikWebIntegrationId + '\',\''+ csrfTokenInfo.headers.get("qlik-csrf-token") + '\',\''+ iframe_style+ '\',\''+ question.replace(/'/g, "\\'") + '\',\''+ desc.replace(/'/g, "\\'") +'\',\''+ asked+ '\',\''+ limitations.replace(/\"/g,"'").replace(/'/g, "\\'").replace(/\r?\n/g,"")+'\');"><h5 style="color: #376076;">' + question + '</h5></a>'
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

var changeclick = function(){
	$("#question-table2 tbody td").removeClass('row_selected');        
};

function question_detail_toggle() {
	var divContainer = document.getElementById("question-detail-toggle");
	var panel = document.getElementById("iframe_details");
	if (panel.style.display === "block") {
		divContainer.innerHTML = "<i class='fas fa-chevron-right'></i> Limitations";
		panel.style.display = "none";
	} else {
		divContainer.innerHTML = "<i class='fas fa-chevron-down'></i> Limitations";
		panel.style.display = "block";
	}
	
}

function iframe_render(tenant, appID, content, integrationID, token, style, question, description, asked, limitations) {
	var divContainer = document.getElementById("question-tile");
	divContainer.innerHTML = 
		'<h2>' + question + '</h2>'
	  +'<p>' + description + '</p>'
	  +'<iframe src="https://'+tenant+'/single/?appid='+appID+'&sheet='+content
	  +'&qlik-web-integration-id='+integrationID
	  +'&qlik-csrf-token='+token+'" style="'+style+'" ></iframe>'
		+'<br><a class="accordion-toggle" data-toggle="collapse" data-parent="#iframe_accordion" href="#iframe_details" onclick="question_detail_toggle()"><span id="question-detail-toggle"><i class="fas fa-chevron-right"></i> Limitations</span></a>'
		+'<div id="iframe_accordian">'
			+'<div id="iframe_details" class="panel-body panel-collapse collapse">'
	  			+'<p><strong>Limitations:</strong> ' + limitations + '</p>'
	  		+'</div>'
	  	+'</div>'
;
}
</script>