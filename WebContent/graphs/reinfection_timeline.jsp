<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<style>
.d3_question_header{
	text-align:center; 
	color:#fff; 
	background: #454F82;
	font-family: Arial, Helvetica, sans-serif;
	font-size:18px; 
	padding: 3px; 
	margin-top:20px;
}
button {
	border-radius: 5px;
    background: #2363ff;
    color: white;
    border: 2px solid #b0afae;
    padding: 7px;
}

</style>

<div class="row stats">
	<div class="col-xs-12 col-lg-12">
		<div class="d3_question_header">
		Patient Counts: First Diagnosis Versis Reinfected Patients Per COVID+ Cohort
		</div>
	
		<div>
			<div id="reinfection_kpi" class="col-xs-2" >
			     <sql:query var="totals" dataSource="jdbc/N3CCohort">
			     	select to_char(value::int/1000000.0, '999.99')||'M' as count from n3c_admin.enclave_stats where title='covid_positive_patients';
			     </sql:query>
			     <c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
					<div class=" panel-primary">
						<div class="panel-body">
							<table><tr><td><i class="fas fa-user-plus"></i></td><td>&nbsp;</td><td>COVID+ Patients</td></tr></table>
						</div>
						<div class="panel-heading">
			     			${row.count}
			     		</div>
			     	</div>
			     </c:forEach>
			     <sql:query var="totals" dataSource="jdbc/N3CCohort">
			     	select to_char(sum(first_diagnosis)/1000000.0, '999.99')||'M' as first_diagnosis, to_char(sum(reinfected)/1000.0, '999.99')||'k' as reinfected
			     	from (select 
			     			case
								when (first_diagnosis_count = '<20' or first_diagnosis_count is null) then 0
								else first_diagnosis_count::int
							end as first_diagnosis,
							case
								when (original_infection_date_for_reinfected_count = '<20' or original_infection_date_for_reinfected_count is null) then 0
								else original_infection_date_for_reinfected_count::int
							end as reinfected
							from n3c_questions.covid_lds_with_reinfection_date_counts_censored) as foo
			     </sql:query>
			     <c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
						<div class="panel-body">
							<table><tr><td><i class="fas fa-users"></i></td><td>&nbsp;</td><td>First Diagnosis Count *</td></tr></table>
						</div>
						<div id="first_diagnosis_kpi" class="panel-heading">
			     			${row.first_diagnosis}
			     		</div>
						<div class="panel-body">
							<table><tr><td><i class="fas fa-users"></i></td><td>&nbsp;</td><td>Reinfection Count *</td></tr></table>
						</div>
						<div id="reinfected_kpi" class="panel-heading">
			     			${row.reinfected}
			     		</div>
			     </c:forEach>
				<div class="panel-body">
					* (see limitations below)
				</div>
			</div>
			<div id="reinfection1" class="col-xs-10" >
				<div id="reinfection1_graph"></div>
				<jsp:include page="../graph_support/time_line_2_column.jsp">
					<jsp:param name="data_page" value="feeds/reinfections_by_date.jsp" />
					<jsp:param name="dom_element" value="#reinfection1" />
					<jsp:param name="namespace" value="reinfection1" />
					<jsp:param name="date_column" value="c_date" />
					<jsp:param name="column1" value="first_diagnosis" />
					<jsp:param name="column1_label" value="First Diagnosis Countt" />
					<jsp:param name="column1_tip" value="First Diagnosis" />
					<jsp:param name="column1_tip_offset" value="110" />
					<jsp:param name="column1_color" value="#163F59" />
					<jsp:param name="column1_opacity" value="0.25" />
					<jsp:param name="column2" value="reinfected" />
					<jsp:param name="column2_label" value="Reinfection Count" />
					<jsp:param name="column2_tip" value="Reinfection" />
					<jsp:param name="column2_tip_offset" value="85" />
					<jsp:param name="column2_color" value="#454F82" />
					<jsp:param name="constraintPropagator" value="constraint" />
				</jsp:include>
				<button id="reinfection1_btn" class="button"><i class="fa fa-filter" aria-hidden="true"></i> Clear all selections</button>
				<p style="text-align:center;">Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.</p>
			</div>
		</div>
	</div>
</div>			
<div class="row stats">
	<div class="col-xs-12 col-lg-12">
		<div class="d3_question_header">
		Patient Counts: First Diagnosis Versus Number of Reinfections Per Day
		</div>
		<div>
			<div id="reinfection_kpi" class="col-xs-2" >
			</div>
			<div id="reinfection2" class="col-xs-10" >
			<div id="reinfection2_graph"></div>
			<jsp:include page="../graph_support/time_line_2_column.jsp">
				<jsp:param name="data_page" value="feeds/reinfections_by_date.jsp" />
				<jsp:param name="dom_element" value="#reinfection2" />
				<jsp:param name="namespace" value="reinfection2" />
				<jsp:param name="date_column" value="c_date" />
				<jsp:param name="column1" value="first_diagnosis" />
				<jsp:param name="column1_label" value="First Diagnosis Count" />
				<jsp:param name="column1_tip" value="First Diagnosis" />
				<jsp:param name="column1_tip_offset" value="110" />
				<jsp:param name="column1_color" value="#163F59" />
				<jsp:param name="column1_opacity" value="0.25" />
				<jsp:param name="column2" value="subsequent_test" />
				<jsp:param name="column2_label" value="Reinfection Count" />
				<jsp:param name="column2_tip" value="Reinfection" />
				<jsp:param name="column2_tip_offset" value="120" />
				<jsp:param name="column2_color" value="#454F82" />
			</jsp:include>
			<button id="reinfection2_btn" class="button"><i class="fa fa-filter" aria-hidden="true"></i> Clear all selections</button>
				<p style="text-align:center;">Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.</p>
			</div>
		</div>
	</div>
</div>			
		
<div class="row stats">
	<div class="col-xs-12 col-lg-12">
		<div class="d3_question_header">
		</div>
		<div id="reinfection_table">
			<p>&nbsp;</p>
			<div class="col-xs-3">&nbsp;</div>
			<div class="col-xs-7" id="reinfections-by-date"></div>
			<jsp:include page="../tables/reinfections_by_date.jsp"/>
		</div>
	</div>
		
</div>
