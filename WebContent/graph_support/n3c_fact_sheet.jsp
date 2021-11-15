<div style="text-align:center; font-size:16px;">
	<div class="row" style="display: flex; flex-direction: row; flex-wrap: wrap; padding: 0px;">
		<div class="col-xs-12" style="margin-bottom:10px;">
			<h4 style="margin-top:0px;">Release Set:	<span id="date"></span></h4>
			<p><strong>Production version:</strong> <span id="production_date">&nbsp;</span></p>
		</div>
	</div>

	<div class="row" style="display: flex; flex-direction: row; flex-wrap: wrap; padding: 10px; font-size:20px; webkit-box-shadow: 1px 2px 30px 2px rgba(92,123,128,0.72); -moz-box-shadow: 1px 2px 30px 2px rgba(92,123,128,0.72); box-shadow: 1px 2px 30px 2px rgba(92,123,128,0.72); border-radius: 5px; margin-left: 10px; margin-right: 10px; padding-bottom:30px; padding-top:30px;">
		<div class="col-xs-12 col-md-6">
			<p><strong><i class="far fa-hospital"></i>	Sites:	</strong>	<span id="sites">&nbsp;</span></p>
			<p><strong><i class="fa fa-user"></i>	Persons:	</strong>	<span id="persons">&nbsp;</span></p>
			<p><strong><i class="fa fa-plus"></i>	COVID+ Cases:	</strong> <span id="positive">&nbsp;</span></p>
			<p><strong><i class="fa fa-table"></i>	Total Number of Rows:	</strong> <span id="rows">&nbsp;</span></p>
			<p><strong><i class="fa fa-user-md"></i>	Clinical Observations:	</strong> <span id="observations">&nbsp;</span></p>
		</div>
		<div class="col-xs-12 col-md-6">
			<p><strong><i class="fa fa-heartbeat"></i>	Lab Results:</strong> <span id="results">&nbsp;</span></p>
			<p><strong><i class="fa fa-id-card"></i>	Medication Records:</strong> <span id="records">&nbsp;</span></p>
			<p><strong><i class="fa fa-list"></i>	Procedures:</strong> <span id="procedures">&nbsp;</span></p>
			<p><strong><i class="far fa-calendar-alt"></i>	Visits:</strong>	<span id="visits"></span></p>
		</div>
	</div>

	<p style="margin-top:40px;">For more information about the release set, please visit the <a href="https://github.com/National-COVID-Cohort-Collaborative/Data-Ingestion-and-Harmonization/wiki" target="_blank">N3C Data Ingestion &amp; Harmonization GitHub Repository</a>.</p>
</div>

<script>
	$.getJSON("https://labs.cd2h.org/n3c_dashboard/embedded_fact_sheet.jsp", function(json){
		var data = $.parseJSON(JSON.stringify(json));

		$('#date').text(data['release_date']); 
		$('#production_date').text(data['release_name']); 


		$('#sites').text(data['sites_ingested']); 	
		$('#persons').text(data['person_rows']); 
		$('#positive').text(data['covid_positive_patients']); 
		$('#rows').text(data['total_rows']);
		$('#observations').text(data['observation_rows']);
		$('#results').text(data['measurement_rows']);
		$('#records').text(data['drug_exposure_rows']);
		$('#procedures').text(data['procedure_rows']);
		$('#visits').text(data['visit_rows']);  	
	});

</script>