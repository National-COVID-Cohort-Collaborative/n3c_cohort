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

<sql:query var="questions" dataSource="jdbc/N3CCohort">
	select question,description,limitations from n3c_questions.roster where iframe_info = ?;
	<sql:param>${param.question}</sql:param>
</sql:query>
<c:forEach items="${questions.rows}" var="row" varStatus="rowCounter">
	<h2>${row.question}</h2>
	<p>${row.description}</p>
	<c:set var="limitations">${row.limitations}</c:set>
</c:forEach>
<div class="row stats">
	<div class="col-xs-12 col-lg-12">
		<div class="d3_question_header">
			COVID+ Patients: Daily Patient Counts and 7-Day Rolling Averages
		</div>
		<div id="pos_rolling">
			<div id="pos_rolling_graph"></div>
			<c:set var="feedPath"><util:applicationRoot/>/feeds/positive_cases_by_date.jsp</c:set>
			<jsp:include page="../graph_support/time_line_2_column.jsp">
				<jsp:param name="data_page" value="${feedPath}" />
				<jsp:param name="dom_element" value="#pos_rolling" />
				<jsp:param name="namespace" value="pos_rolling" />
				<jsp:param name="date_column" value="first_diagnosis_date" />
				<jsp:param name="column1" value="positive_cases" />
				<jsp:param name="column1_label" value="COVID+ Patient Count" />
				<jsp:param name="column1_tip" value="COVID+" />
				<jsp:param name="column1_tip_offset" value="70" />
				<jsp:param name="column2" value="seven_day_rolling_avg" />
				<jsp:param name="column2_label" value="Rolling 7-Day Average Patient Count" />
				<jsp:param name="column2_tip" value="7-Day Ave" />
				<jsp:param name="column2_tip_offset" value="80" />
				<jsp:param name="useColumn1Scaling" value="true" />
				<jsp:param name="column1_opacity" value="0.25" />
				<jsp:param name="constraintPropagator" value="constraint" />
			</jsp:include>
		
			<button id="pos_rolling_btn" class="button"><i class="fa fa-filter" aria-hidden="true"></i> Clear all selections</button>
			<p style="text-align:center;">Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.</p>
		</div>
	
		<div class="d3_question_header">
			COVID+ Patients: Cumulative and 7-Day Rolling Average Counts
		</div>
		<div id="pos_cumulative">
			<div id="pos_cumulative_graph"></div>
			<jsp:include page="../graph_support/time_line_2_column.jsp">
				<jsp:param name="data_page" value="${feedPath}" />
				<jsp:param name="dom_element" value="#pos_cumulative" />
				<jsp:param name="namespace" value="pos_cumulative" />
				<jsp:param name="date_column" value="first_diagnosis_date" />
				<jsp:param name="column1" value="cumsum_positivecases" />
				<jsp:param name="column1_label" value="Cumulative COVID+ Patient Count" />
				<jsp:param name="column1_tip" value="Cumulative" />
				<jsp:param name="column1_tip_offset" value="90" />
				<jsp:param name="column2" value="seven_day_rolling_avg" />
				<jsp:param name="column2_label" value="Rolling 7-Day Average Patient Count" />
				<jsp:param name="column2_tip" value="7-Day Ave" />
				<jsp:param name="column2_tip_offset" value="80" />
			</jsp:include>

			<button id="pos_cumulative_btn" class="button"><i class="fa fa-filter" aria-hidden="true"></i> Clear all selections</button>
			<p style="text-align:center;">Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.</p>

		</div>

		<div class="d3_question_header">
		</div>
		<div id="pos_table">
			<p>&nbsp;</p>
			<div class="col-xs-2">&nbsp;</div>
			<div class="col-xs-8" id="positives-by-date"></div>
			<jsp:include page="../tables/positive_cases_by_date.jsp"/>
		</div>
	</div>
		
</div>
