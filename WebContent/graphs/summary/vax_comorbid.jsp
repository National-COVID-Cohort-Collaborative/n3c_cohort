<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row stats">
	<div class="col-xs-2 ">
		<a onclick="uncheckAll();">Reset Filters</a>
		<div id="mode" class="panel-heading">
			Display: <i id="mode-pie" class="fas fa-chart-pie fa-lg"></i> <i id="mode-bar" class="fas fa-chart-bar fa-lg text-success"></i>
		</div>
		<div class=" panel-primary">
			<div class="panel-body">
				<h4 id="age"><i class="fas fa-chevron-right"></i> Age</h4>
				<div id="age_panel" style="display:none;">
					<sql:query var="ages" dataSource="jdbc/N3CCohort">
						select age_bin,sum(patient_count) from n3c_dashboard.aggregated group by 1 order by 1;
					</sql:query>
					<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="age_bin" value="${row.age_bin}" > ${row.age_bin} (${row.sum})
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h4 id="race"><i class="fas fa-chevron-right"></i> Race</h4>
				<div id="race_panel" style="display:none;">
					<sql:query var="races" dataSource="jdbc/N3CCohort">
						select race,race_abbrev,sum(patient_count) from n3c_dashboard.aggregated natural join n3c_dashboard.race_map group by 1,2,race_seq order by race_seq;
					</sql:query>
					<c:forEach items="${races.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="race" value="${row.race}" > ${row.race_abbrev} (${row.sum})
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h4 id="ethnicity"><i class="fas fa-chevron-right"></i> Ethnicity</h4>
				<div id="ethnicity_panel" style="display:none;">
					<sql:query var="ethnicities" dataSource="jdbc/N3CCohort">
						select aggregated.ethnicity,ethnicity_abbrev,sum(patient_count) from n3c_dashboard.aggregated natural join n3c_dashboard.ethnicity_map group by 1,2,ethnicity_seq order by ethnicity_seq;
					</sql:query>
					<c:forEach items="${ethnicities.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="ethnicity" value="${row.ethnicity}" > ${row.ethnicity_abbrev} (${row.sum})
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h4 id="gender"><i class="fas fa-chevron-right"></i> Gender</h4>
				<div id="gender_panel" style="display:none;">
					<sql:query var="genders" dataSource="jdbc/N3CCohort">
						select gender,gender_abbrev,sum(patient_count) from n3c_dashboard.aggregated natural join n3c_dashboard.gender_map group by 1,2,gender_seq order by gender_seq;
					</sql:query>
					<c:forEach items="${genders.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="gender" value="${row.gender}" > ${row.gender_abbrev} (${row.sum})
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h4 id="severity"><i class="fas fa-chevron-right"></i> Severity</h4>
				<div id="severity_panel" style="display:none;">
					<sql:query var="severities" dataSource="jdbc/N3CCohort">
						select severity,severity_abbrev,sum(patient_count) from n3c_dashboard.aggregated natural join n3c_dashboard.severity_map group by 1,2,severity_seq order by severity_seq;
					</sql:query>
					<c:forEach items="${severities.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="severity" value="${row.severity}" > ${row.severity_abbrev} (${row.sum})
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<div class="col-xs-10">
         <div class="pubhealth-panel panel panel-primary top_panel shadow-border">
             <ul class="nav nav-tabs" style="font-size: 16px;">
                <li class="active"><a data-toggle="tab" href="#vax_comorbid_severity">Severity</a></li>
                <li><a data-toggle="tab" href="#vax_comorbid_age">Age</a></li>
                <li><a data-toggle="tab" href="#vax_comorbid_gender">Gender</a></li>
                <li><a data-toggle="tab" href="#vax_comorbid_race">Race</a></li>
                <li><a data-toggle="tab" href="#vax_comorbid_ethnicity">Ethnicity</a></li>
            </ul>
		<div id="tab-content">
			<div class="tab-pane fade in active" id="vax_comorbid_severity">
				<h5>Severity</h5>
				<div class="panel-body">
					<div id="severity_histogram"></div>
				</div>
			</div>
6			<div class="tab-pane fade" id="vax_comorbid_age">
				<h5>Age</h5>
				<div class="panel-heading">
					<div id="age_histogram"></div>
				</div>
			</div>
			<div class="tab-pane fade" id="vax_comorbid_gender">
				<h5>Gender</h5>
				<div class="panel-body">
					<div id="gender_histogram"></div>
				</div>
			</div>
			<div class="tab-pane fade" id="vax_comorbid_race">
				<h5>Race</h5>
				<div class="panel-body">
					<div id="race_histogram"></div>
				</div>
			</div>
			<div class="tab-pane fade" id="vax_comorbid_ethnicity">
				<h5>Ethnicity</h5>
				<div class="panel-heading">
					<div id="ethnicity_histogram"></div>
				</div>
			</div>
		</div>
		<div id="display-table" style="display:block" class="panel panel-primary">
			<div class="panel-heading">Aggregated Data</div>
			<div class="panel-body">
				<div id="aggregated"></div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../../graph_support/verticalBarChart_local.jsp"/>
<jsp:include page="../../graph_support/pieChart_local.jsp"/>
<script>
var aggregated_datatable = null;
var ageArray = new Array();
var raceArray = new Array();
var ethnicityArray = new Array();
var genderArray = new Array();
var severityArray = new Array();

$(document).ready( function () {
	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="race"]:checked').map(function() {
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
		      var positions = $('input:checkbox[name="ethnicity"]:checked').map(function() {
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
		      var positions = $('input:checkbox[name="age_bin"]:checked').map(function() {
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
		      var positions = $('input:checkbox[name="gender"]:checked').map(function() {
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
		      var positions = $('input:checkbox[name="severity"]:checked').map(function() {
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
	
	$.getJSON("feeds/aggregated.jsp", function(data){
			
		var json = $.parseJSON(JSON.stringify(data));
		var col = [];
	
		for (i in json['headers']){
			col.push(json['headers'][i]['label']);
		}
	
	
		var table = document.createElement("table");
		table.className = 'table table-hover compact site-wrapper';
		table.style.width = '100%';
		table.id="aggregated-table";
	
		var header= table.createTHead();
		var header_row = header.insertRow(0); 
	
		for (i in col) {
			var th = document.createElement("th");
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
			header_row.appendChild(th);
		}
	
		var divContainer = document.getElementById("aggregated");
		divContainer.appendChild(table);
	
		var data = json['rows'];
	
		aggregated_datatable = $('#aggregated-table').DataTable( {
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
	
		refreshHistograms();
	});
	
	$('input:checkbox').on('change', function () {
	    aggregated_datatable.draw();
	    refreshHistograms();
	 });
} );

function refreshHistograms() {
    var data = aggregated_datatable.rows({search:'applied'}).data().toArray();
    refreshAgeArray(data);
    refreshRaceArray(data);
    refreshEthnicityArray(data);
    refreshGenderArray(data);
    refreshSeverityArray(data);
    
    var doBar = false;
    if (document.getElementById("mode-bar").classList.contains("text-success")) {
    	doBar = true;
    }
    d3.select("#age_histogram").select("svg").remove();
    if (doBar)
    	localBarChart(ageArray,"#age_histogram",120);
    else
    	localPieChart(ageArray,"#age_histogram");

    d3.select("#race_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(raceArray,"#race_histogram",120);
    else
    	localPieChart(raceArray,"#race_histogram");

    d3.select("#ethnicity_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(ethnicityArray,"#ethnicity_histogram",120);
    else
    	localPieChart(ethnicityArray,"#ethnicity_histogram");

    d3.select("#gender_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(genderArray,"#gender_histogram",120);
    else
    	localPieChart(genderArray,"#gender_histogram");

    d3.select("#severity_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(severityArray,"#severity_histogram",120);
    else
    	localPieChart(severityArray,"#severity_histogram");
}

function refreshAgeArray(data) {
	var aData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].age_bin;
    	var count = data[i].patient_count;
        if (typeof aData[group] == 'undefined') {
            aData[group] = count;
         } else
        	 aData[group] += count;
	});

	ageArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	ageArray.push(obj);
    }
    ageArray.sort((a,b) => (a.element > b.element) ? 1 : ((b.element > a.element) ? -1 : 0));
    console.log(ageArray);
}

function refreshRaceArray(data) {
	var aData = new Object;
	var bData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
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

    raceArray = new Array();
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
    	raceArray.push(obj);
    }
    raceArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
    console.log(raceArray);
}

function refreshEthnicityArray(data) {
	var aData = new Object;
	var bData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].ethnicity_abbrev;
    	var count = data[i].patient_count;
    	var seq = data[i].ethnicity_seq;
        if (typeof aData[group] == 'undefined') {
            aData[group] = count;
            bData[group] = seq;
         } else
        	 aData[group] += count;
	});

	ethnicityArray = new Array();
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
    	ethnicityArray.push(obj);
    }
    ethnicityArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
    console.log(ethnicityArray);
}

function refreshGenderArray(data) {
	var aData = new Object;
	var bData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
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

	genderArray = new Array();
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
    	genderArray.push(obj);
    }
    genderArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
    console.log(genderArray);
}

function refreshSeverityArray(data) {
	var aData = new Object;
	var bData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
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

	severityArray = new Array();
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
    	severityArray.push(obj);
    }
    severityArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
    console.log(severityArray);
}

function uncheckAll(){
	$('input[type="checkbox"]:checked').prop('checked',false);
	aggregated_datatable.draw();
	refreshHistograms();
}

$('#mode-bar').on('click', function(element) {
	if (!document.getElementById("mode-bar").classList.contains("text-success")) {
		document.getElementById("mode-bar").classList.add("text-success");
	}
	document.getElementById("mode-pie").classList.remove("text-success");
	document.getElementById("mode-table").classList.remove("text-success");
	document.getElementById("display-d3").style.display = "block";
	refreshHistograms();
});
$('#mode-pie').on('click', function(element) {
	if (!document.getElementById("mode-pie").classList.contains("text-success")) {
		document.getElementById("mode-pie").classList.add("text-success");
	}
	document.getElementById("mode-bar").classList.remove("text-success");
	document.getElementById("mode-table").classList.remove("text-success");
	document.getElementById("display-d3").style.display = "block";
	refreshHistograms();
});

$('#age').on('click', function() {
	var panel = document.getElementById("age_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Age";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Age";
		panel.style.display = "none";
	}
});
$('#race').on('click', function() {
	var panel = document.getElementById("race_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Race";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Race";
		panel.style.display = "none";
	}
});
$('#ethnicity').on('click', function() {
	var panel = document.getElementById("ethnicity_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Ethnicity";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Ethnicity";
		panel.style.display = "none";
	}
});
$('#gender').on('click', function() {
	var panel = document.getElementById("gender_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Gender";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Gender";
		panel.style.display = "none";
	}
});
$('#severity').on('click', function() {
	var panel = document.getElementById("severity_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Severity";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Severity";
		panel.style.display = "none";
	}
});
</script>
