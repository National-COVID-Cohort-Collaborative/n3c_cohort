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
    .button {
        fill: #2052FF;
        stroke: #000;
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
	Patient Counts: First Diagnosis Versis Reinfected Patients Per COVID+ Cohort
	</div>
		<div id="reinfection1">
			<jsp:include page="../graph_support/time_line_2_column.jsp">
				<jsp:param name="data_page" value="feeds/reinfections_by_date.jsp" />
				<jsp:param name="dom_element" value="#reinfection1" />
				<jsp:param name="namespace" value="reinfection1" />
				<jsp:param name="date_column" value="c_date" />
				<jsp:param name="column1" value="first_diagnosis" />
				<jsp:param name="column1_label" value="First Diagnosis Countt" />
				<jsp:param name="column1_tip" value="First Diagnosis" />
				<jsp:param name="column1_tip_offset" value="110" />
				<jsp:param name="column2" value="reinfected" />
				<jsp:param name="column2_label" value="Reinfected Count" />
				<jsp:param name="column2_tip" value="Reinfected" />
				<jsp:param name="column2_tip_offset" value="85" />
				<jsp:param name="column1_opacity" value="0.25" />
			</jsp:include>
		</div>
			<p style="text-align:center;">Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.</p>
	<div class="d3_question_header">
	Patient Counts: First Diagnosis Versus Number of Reinfections Per Day
	</div>
		<div id="reinfection2">
			<jsp:include page="../graph_support/time_line_2_column.jsp">
				<jsp:param name="data_page" value="feeds/reinfections_by_date.jsp" />
				<jsp:param name="dom_element" value="#reinfection2" />
				<jsp:param name="namespace" value="reinfection2" />
				<jsp:param name="date_column" value="c_date" />
				<jsp:param name="column1" value="first_diagnosis" />
				<jsp:param name="column1_label" value="First Diagnosis Count" />
				<jsp:param name="column1_tip" value="First Diagnosis" />
				<jsp:param name="column1_tip_offset" value="110" />
				<jsp:param name="column2" value="subsequent_test" />
				<jsp:param name="column2_label" value="Subsequent Test Count" />
				<jsp:param name="column2_tip" value="Subsequent Test" />
				<jsp:param name="column2_tip_offset" value="120" />
				<jsp:param name="column1_opacity" value="0.25" />
			</jsp:include>
		</div>
			<p style="text-align:center;">Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.</p>
	</div>
		
</div>
