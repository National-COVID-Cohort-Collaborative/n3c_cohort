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
		Patient Counts: First Diagnosis Versus Reinfected Patients Per COVID+ Cohort
		</div>
	
		<div>
			<div id="reinfection_kpi" class="col-xs-2" >
				<jsp:include page="../kpis/covid_positive.jsp"/>
				<jsp:include page="../kpis/covid_first_diagnosis.jsp"/>
				<jsp:include page="../kpis/covid_reinfections.jsp"/>
				<div class="panel-body" style="color: #1E39F4">
					* (see limitations below)
				</div>
				<button id="reinfection1_btn" class="button"><i class="fa fa-filter" aria-hidden="true"></i> Clear all selections</button>
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
				<p style="text-align:center;">
					<sql:query var="cases" dataSource="jdbc/N3CCohort">
						select
							to_char(c_date::date, 'FMMM/FMDD/YY') as date,
							to_char(first_diagnosis_count::int,'999,999') as first_diagnosis,
							to_char(original_infection_date_for_reinfected_count::int, '999,999') as reinfection
						from n3c_questions.covid_lds_with_reinfection_date_counts_censored where c_date ='2020-03-28'
					</sql:query>
					<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
						The numbers indicate counts of first diagnosis for that date and counts of reinfection for that specific cohort.
						As an example for ${row.date}, count that had a positive test was ${row.first_diagnosis} and of this cohort of ${row.first_diagnosis}, ${row.reinfection} were reinfected.
					</c:forEach>
					Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.
				</p>
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
				<jsp:include page="../kpis/covid_positive.jsp"/>
				<jsp:include page="../kpis/covid_first_diagnosis.jsp"/>
				<div class="panel-body" style="color: #1E39F4">
					* (see limitations below)
				</div>
				<button id="reinfection2_btn" class="button"><i class="fa fa-filter" aria-hidden="true"></i> Clear all selections</button>
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
			<p style="text-align:center;">
					<sql:query var="cases" dataSource="jdbc/N3CCohort">
						select
							to_char(c_date::date, 'FMMM/FMDD/YY') as date,
							to_char(first_diagnosis_count::int,'999,999') as first_diagnosis,
							to_char(subsequent_test_count::int, '999,999') as subsequent
						from n3c_questions.covid_lds_with_reinfection_date_counts_censored where c_date ='2021-09-06'
					</sql:query>
					<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
						The numbers indicate counts of first diagnosis and counts of reinfection for that date.
						As an example for ${row.date}, the counts indicates that ${row.first_diagnosis} had a first positive test, ${row.subsequent} indicates reinfection counts.
					</c:forEach>
				Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.
			</p>
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
