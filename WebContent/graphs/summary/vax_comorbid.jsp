<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row stats">
	<div class="col-xs-2 ">
		<a onclick="${param.namespace}_uncheckAll();">Reset Filters</a>
		<div id="mode" class="panel-heading">
			Display: <i id="${param.namespace}-mode-pie" class="fas fa-chart-pie fa-lg"></i> <i id="${param.namespace}-mode-bar" class="fas fa-chart-bar fa-lg text-success"></i>
		</div>
		<div class=" panel-primary">
			<div class="panel-body">
				<h4 id="${param.namespace}_age"><i class="fas fa-chevron-right"></i> Age</h4>
				<div id="${param.namespace}_age_panel" style="display:none;">
					<sql:query var="ages" dataSource="jdbc/N3CCohort">
						select age_bin,sum(patient_count) from n3c_dashboard.aggregated group by 1 order by 1;
					</sql:query>
					<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="${param.namespace}_age" value="${row.age_bin}" > ${row.age_bin} (${row.sum})
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h4 id="${param.namespace}_race"><i class="fas fa-chevron-right"></i> Race</h4>
				<div id="${param.namespace}_race_panel" style="display:none;">
					<sql:query var="races" dataSource="jdbc/N3CCohort">
						select race,race_abbrev,sum(patient_count) from n3c_dashboard.aggregated natural join n3c_dashboard.race_map group by 1,2,race_seq order by race_seq;
					</sql:query>
					<c:forEach items="${races.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="${param.namespace}_race" value="${row.race}" > ${row.race_abbrev} (${row.sum})
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h4 id="${param.namespace}_ethnicity"><i class="fas fa-chevron-right"></i> Ethnicity</h4>
				<div id="${param.namespace}_ethnicity_panel" style="display:none;">
					<sql:query var="ethnicities" dataSource="jdbc/N3CCohort">
						select aggregated.ethnicity,ethnicity_abbrev,sum(patient_count) from n3c_dashboard.aggregated natural join n3c_dashboard.ethnicity_map group by 1,2,ethnicity_seq order by ethnicity_seq;
					</sql:query>
					<c:forEach items="${ethnicities.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="${param.namespace}_ethnicity" value="${row.ethnicity}" > ${row.ethnicity_abbrev} (${row.sum})
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h4 id="${param.namespace}_gender"><i class="fas fa-chevron-right"></i> Gender</h4>
				<div id="${param.namespace}_gender_panel" style="display:none;">
					<sql:query var="genders" dataSource="jdbc/N3CCohort">
						select gender,gender_abbrev,sum(patient_count) from n3c_dashboard.aggregated natural join n3c_dashboard.gender_map group by 1,2,gender_seq order by gender_seq;
					</sql:query>
					<c:forEach items="${genders.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="${param.namespace}_gender" value="${row.gender}" > ${row.gender_abbrev} (${row.sum})
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h4 id="${param.namespace}_severity"><i class="fas fa-chevron-right"></i> Severity</h4>
				<div id="${param.namespace}_severity_panel" style="display:none;">
					<sql:query var="severities" dataSource="jdbc/N3CCohort">
						select severity,severity_abbrev,sum(patient_count) from n3c_dashboard.aggregated natural join n3c_dashboard.severity_map group by 1,2,severity_seq order by severity_seq;
					</sql:query>
					<c:forEach items="${severities.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="${param.namespace}_severity" value="${row.severity}" > ${row.severity_abbrev} (${row.sum})
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<div class="col-xs-10">
         <div class="pubhealth-panel panel panel-primary top_panel shadow-border">
             <ul class="nav nav-tabs" style="font-size: 16px;">
                <li class="active"><a data-toggle="tab" href="#${param.namespace}_severity_tab">Severity</a></li>
                <li><a data-toggle="tab" href="#${param.namespace}_age_tab">Age</a></li>
                <li><a data-toggle="tab" href="#${param.namespace}_gender_tab">Gender</a></li>
                <li><a data-toggle="tab" href="#${param.namespace}_race_tab">Race</a></li>
                <li><a data-toggle="tab" href="#${param.namespace}_ethnicity_tab">Ethnicity</a></li>
            </ul>
		<div id="tab-content">
			<div class="tab-pane fade in active" id="${param.namespace}_severity_tab">
				<h5>Severity</h5>
				<div class="panel-body">
					<div id="${param.namespace}_severity_histogram"></div>
				</div>
			</div>
			<div class="tab-pane fade" id="${param.namespace}_age_tab">
				<h5>Age</h5>
				<div class="panel-heading">
					<div id="${param.namespace}_age_histogram"></div>
				</div>
			</div>
			<div class="tab-pane fade" id="${param.namespace}_gender_tab">
				<h5>Gender</h5>
				<div class="panel-body">
					<div id="${param.namespace}_gender_histogram"></div>
				</div>
			</div>
			<div class="tab-pane fade" id="${param.namespace}_race_tab">
				<h5>Race</h5>
				<div class="panel-body">
					<div id="${param.namespace}_race_histogram"></div>
				</div>
			</div>
			<div class="tab-pane fade" id="${param.namespace}_ethnicity_tab">
				<h5>Ethnicity</h5>
				<div class="panel-heading">
					<div id="${param.namespace}_ethnicity_histogram"></div>
				</div>
			</div>
		</div>
		<div id="${param.dom_element}-display-table" style="display:block" class="panel panel-primary">
			<div class="panel-body">
				<div id="${param.dom_element}"></div>
			</div>
		</div>
	</div>
</div>
</div>
<jsp:include page="../../graph_support/verticalBarChart_local.jsp"/>
<jsp:include page="../../graph_support/pieChart_local.jsp"/>
<script>
var ${param.namespace}_datatable = null;
var ${param.namespace}_ageArray = new Array();
var ${param.namespace}_raceArray = new Array();
var ${param.namespace}_ethnicityArray = new Array();
var ${param.namespace}_genderArray = new Array();
var ${param.namespace}_severityArray = new Array();

$(document).ready( function () {
	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="${param.namespace}_race"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[0]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );
	
	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="${param.namespace}_ethnicity"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[1]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );

	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="${param.namespace}_age"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[2]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );

	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="${param.namespace}_gender"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[3]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );

	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="${param.namespace}_severity"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[4]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );
	
	$.getJSON("<util:applicationRoot/>/feeds/aggregated.jsp", function(data){
			
		var json = $.parseJSON(JSON.stringify(data));
		var col = [];
	
		for (i in json['headers']){
			col.push(json['headers'][i]['label']);
		}
	
	
		var table = document.createElement("table");
		table.className = 'table table-hover compact site-wrapper';
		table.style.width = '100%';
		table.id="${param.dom_element}-table";
	
		var header= table.createTHead();
		var header_row = header.insertRow(0); 
	
		for (i in col) {
			var th = document.createElement("th");
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
			header_row.appendChild(th);
		}
	
		var divContainer = document.getElementById("${param.dom_element}");
		divContainer.appendChild(table);
	
		var data = json['rows'];
	
		${param.namespace}_datatable = $('#${param.dom_element}-table').DataTable( {
			"dom": '<l<t>ip>',
	    	data: data,
	       	paging: true,
	    	pageLength: 10,
	    	lengthMenu: [ 10, 25, 50, 75, 100 ],
	    	order: [[0, 'asc']],
	     	columns: [
	        	{ data: 'race', visible: true, orderable: true },
	        	{ data: 'ethnicity', visible: true, orderable: true },
	        	{ data: 'age_bin', visible: true, orderable: true },
	        	{ data: 'gender', visible: true, orderable: true },
	        	{ data: 'severity', visible: true, orderable: true },
	        	{ data: 'patient_count', visible: true, orderable: true },
	        	{ data: 'age_abbrev', visible: false },
	        	{ data: 'age_seq', visible: false },
	        	{ data: 'race_abbrev', visible: false },
	        	{ data: 'race_seq', visible: false },
	        	{ data: 'ethnicity_abbrev', visible: false },
	        	{ data: 'ethnicity_seq', visible: false },
	        	{ data: 'gender_abbrev', visible: false },
	        	{ data: 'gender_seq', visible: false },
	        	{ data: 'severity_abbrev', visible: false },
	        	{ data: 'severity_seq', visible: false }
	    	]
		} );
	
		${param.namespace}_refreshHistograms();
	});
	
	$('input:checkbox').on('change', function () {
		${param.namespace}_datatable.draw();
		${param.namespace}_refreshHistograms();
	 });
} );

function ${param.namespace}_refreshHistograms() {
    var data = ${param.namespace}_datatable.rows({search:'applied'}).data().toArray();
    ${param.namespace}_refreshAgeArray(data);
    ${param.namespace}_refreshRaceArray(data);
    ${param.namespace}_refreshEthnicityArray(data);
    ${param.namespace}_refreshGenderArray(data);
    ${param.namespace}_refreshSeverityArray(data);
    
    var doBar = false;
    if (document.getElementById("${param.namespace}-mode-bar").classList.contains("text-success")) {
    	doBar = true;
    }
    d3.select("#${param.namespace}_age_histogram").select("svg").remove();
    if (doBar)
    	localBarChart(${param.namespace}_ageArray,"#${param.namespace}_age_histogram",120);
    else
    	localPieChart(${param.namespace}_ageArray,"#${param.namespace}_age_histogram");

    d3.select("#${param.namespace}_race_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(${param.namespace}_raceArray,"#${param.namespace}_race_histogram",120);
    else
    	localPieChart(${param.namespace}_raceArray,"#${param.namespace}_race_histogram");

    d3.select("#${param.namespace}_ethnicity_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(${param.namespace}_ethnicityArray,"#${param.namespace}_ethnicity_histogram",120);
    else
    	localPieChart(${param.namespace}_ethnicityArray,"#${param.namespace}_ethnicity_histogram");

    d3.select("#${param.namespace}_gender_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(${param.namespace}_genderArray,"#${param.namespace}_gender_histogram",120);
    else
    	localPieChart(${param.namespace}_genderArray,"#${param.namespace}_gender_histogram");

    d3.select("#${param.namespace}_severity_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(${param.namespace}_severityArray,"#${param.namespace}_severity_histogram",120);
    else
    	localPieChart(${param.namespace}_severityArray,"#${param.namespace}_severity_histogram");
}

function ${param.namespace}_refreshAgeArray(data) {
	var aData = new Object;
	${param.namespace}_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].age_bin;
    	var count = data[i].patient_count;
        if (typeof aData[group] == 'undefined') {
            aData[group] = count;
         } else
        	 aData[group] += count;
	});

	${param.namespace}_ageArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	${param.namespace}_ageArray.push(obj);
    }
    ${param.namespace}_ageArray.sort((a,b) => (a.element > b.element) ? 1 : ((b.element > a.element) ? -1 : 0));
    console.log(${param.namespace}_ageArray);
}

function ${param.namespace}_refreshRaceArray(data) {
	var aData = new Object;
	var bData = new Object;
	${param.namespace}_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
   	var group = data[i].race;
   	switch (data[i].race) {
   	case "White":
   		group = "White";
   		break;
	case "Black or African American":
		group = "Black";
		break;
	case "Asian":
		group = "Asian";
		break;
   	case "Native Hawaiian or Other Pacific Islander":
   		group = "NHPI";
   		break;
   	case "Other":
   		group = "Other";
   		break;
   	case "Missing/Unknown":
   		group = "Missing";
   		break;
   	};
	var count = data[i].patient_count;
	var seq = data[i].race_seq;
        if (typeof aData[group] == 'undefined') {
            aData[group] = count;
            bData[group] = seq;
         } else
        	 aData[group] += count;
	});

	${param.namespace}_raceArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	Object.defineProperty(obj, 'seq', {
    		  value: bData[i]
    		});
    	${param.namespace}_raceArray.push(obj);
    }
    ${param.namespace}_raceArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
    console.log(${param.namespace}_raceArray);
}

function ${param.namespace}_refreshEthnicityArray(data) {
	var aData = new Object;
	var bData = new Object;
	${param.namespace}_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].ethnicity_abbrev;
    	var count = data[i].patient_count;
    	var seq = data[i].ethnicity_seq;
        if (typeof aData[group] == 'undefined') {
            aData[group] = count;
            bData[group] = seq;
         } else
        	 aData[group] += count;
	});

	${param.namespace}_ethnicityArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	Object.defineProperty(obj, 'seq', {
  		  value: bData[i]
  		});
    	${param.namespace}_ethnicityArray.push(obj);
    }
    ${param.namespace}_ethnicityArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
    console.log(${param.namespace}_ethnicityArray);
}

function ${param.namespace}_refreshGenderArray(data) {
	var aData = new Object;
	var bData = new Object;
	${param.namespace}_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].gender;
       	switch (data[i].gender) {
       	case "MALE":
       		group = "Male";
       		break;
    	case "FEMALE":
    		group = "Female";
    		break;
    	case "OTHER":
    		group = "Other";
    		break;
       	case "Other":
       		group = "Other";
       		break;
       	case "Unkown":
       		group = "Unkown";
       		break;
       	case "Gender unkown":
       		group = "Unkown";
       		break;
       	};
    	var count = data[i].patient_count;
    	var seq = data[i].gender_seq;
      if (typeof aData[group] == 'undefined') {
            aData[group] = count;
            bData[group] = seq;
        } else
        	 aData[group] += count;
	});

	${param.namespace}_genderArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	Object.defineProperty(obj, 'seq', {
    		  value: bData[i]
    		});
    	${param.namespace}_genderArray.push(obj);
    }
    ${param.namespace}_genderArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
    console.log(${param.namespace}_genderArray);
}

function ${param.namespace}_refreshSeverityArray(data) {
	var aData = new Object;
	var bData = new Object;
	${param.namespace}_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].severity;
       	switch (data[i].severity) {
       	case "Mild":
       		group = "Mild";
       		break;
    	case "Mild_ED":
    		group = "Mild in ED ";
    		break;
    	case "Moderate":
    		group = "Moderate";
    		break;
       	case "Severe":
       		group = "Severe";
       		break;
       	case "Dead_w_COVID":
       		group = "Dead w/ COVID";
       		break;
       	};
    	var count = data[i].patient_count;
    	var seq = data[i].severity_seq;
        if (typeof aData[group] == 'undefined') {
            aData[group] = count;
            bData[group] = seq;
         } else
        	 aData[group] += count;
	});

	${param.namespace}_severityArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	Object.defineProperty(obj, 'seq', {
  		  value: bData[i]
  		});
    	${param.namespace}_severityArray.push(obj);
    }
    ${param.namespace}_severityArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
    console.log(${param.namespace}_severityArray);
}

function ${param.namespace}_uncheckAll(){
	$('input[type="checkbox"]:checked').prop('checked',false);
	${param.namespace}_datatable.draw();
	${param.namespace}_refreshHistograms();
}

$('#${param.namespace}-mode-bar').on('click', function(element) {
	if (!document.getElementById("${param.namespace}-mode-bar").classList.contains("text-success")) {
		document.getElementById("${param.namespace}-mode-bar").classList.add("text-success");
	}
	document.getElementById("${param.namespace}-mode-pie").classList.remove("text-success");
	${param.namespace}_refreshHistograms();
});
$('#${param.namespace}-mode-pie').on('click', function(element) {
	if (!document.getElementById("${param.namespace}-mode-pie").classList.contains("text-success")) {
		document.getElementById("${param.namespace}-mode-pie").classList.add("text-success");
	}
	document.getElementById("${param.namespace}-mode-bar").classList.remove("text-success");
	${param.namespace}_refreshHistograms();
});

$('#${param.namespace}_age').on('click', function() {
	var panel = document.getElementById("${param.namespace}_age_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Age";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Age";
		panel.style.display = "none";
	}
});
$('#${param.namespace}_race').on('click', function() {
	var panel = document.getElementById("${param.namespace}_race_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Race";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Race";
		panel.style.display = "none";
	}
});
$('#${param.namespace}_ethnicity').on('click', function() {
	var panel = document.getElementById("${param.namespace}_ethnicity_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Ethnicity";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Ethnicity";
		panel.style.display = "none";
	}
});
$('#${param.namespace}_gender').on('click', function() {
	var panel = document.getElementById("${param.namespace}_gender_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Gender";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Gender";
		panel.style.display = "none";
	}
});
$('#${param.namespace}_severity').on('click', function() {
	var panel = document.getElementById("${param.namespace}_severity_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Severity";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Severity";
		panel.style.display = "none";
	}
});
</script>
