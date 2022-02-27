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
		Patient Counts: First Diagnosis Versis Reinfected Patients Per COVID+ Cohort
		</div>
	
		<div id="reinfection1">
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
				<jsp:param name="column1_color" value="#376076" />
				<jsp:param name="column1_opacity" value="0.25" />
				<jsp:param name="column2" value="reinfected" />
				<jsp:param name="column2_label" value="Reinfected Count" />
				<jsp:param name="column2_tip" value="Reinfected" />
				<jsp:param name="column2_tip_offset" value="85" />
				<jsp:param name="column2_color" value="#7a6788" />
				<jsp:param name="constraintPropagator" value="constraint" />
			</jsp:include>
			<button id="reinfection1_btn" class="button"><i class="fa fa-filter" aria-hidden="true"></i> Clear all selections</button>
			<p style="text-align:center;">Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.</p>
		</div>
				
		<div class="d3_question_header">
		Patient Counts: First Diagnosis Versus Number of Reinfections Per Day
		</div>
		<div id="reinfection2">
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
				<jsp:param name="column1_color" value="#376076" />
				<jsp:param name="column1_opacity" value="0.25" />
				<jsp:param name="column2" value="subsequent_test" />
				<jsp:param name="column2_label" value="Subsequent Test Count" />
				<jsp:param name="column2_tip" value="Subsequent Test" />
				<jsp:param name="column2_tip_offset" value="120" />
				<jsp:param name="column2_color" value="#80c3cb" />
			</jsp:include>
			<button id="reinfection2_btn" class="button"><i class="fa fa-filter" aria-hidden="true"></i> Clear all selections</button>
				<p style="text-align:center;">Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.</p>
		</div>
		
		<div class="d3_question_header">
		Test
		</div>
		<div id="reinfection3">
			<div id="reinfection3_graph"></div>
			<jsp:include page="../graph_support/stacked_bar_zoomable.jsp">
				<jsp:param name="data_page" value="feeds/reinfections_by_date.jsp" />
				<jsp:param name="dom_element" value="#reinfection3" />
				<jsp:param name="namespace" value="reinfection3" />
				<jsp:param name="date_column" value="c_date" />
				<jsp:param name="yaxis_label" value="# of Instances" />
				<jsp:param name="column1" value="first_diagnosis" />
				<jsp:param name="column1_label" value="First Diagnosis Count" />
				<jsp:param name="column1_tip" value="First Diagnosis" />
				<jsp:param name="column1_tip_offset" value="110" />
				<jsp:param name="column1_color" value="#376076" />
				<jsp:param name="column2" value="subsequent_test" />
				<jsp:param name="column2_label" value="Subsequent Test Count" />
				<jsp:param name="column2_tip" value="Subsequent Test" />
				<jsp:param name="column2_tip_offset" value="120" />
				<jsp:param name="column2_color" value="#80c3cb" />
				<jsp:param name="column3" value="reinfected" />
				<jsp:param name="column3_label" value="Reinfected Count" />
				<jsp:param name="column3_tip" value="Reinfected" />
				<jsp:param name="column3_tip_offset" value="85" />
				<jsp:param name="column3_color" value="#7a6788" />
			</jsp:include>
			<button id="reinfection3_btn" class="button"><i class="fa fa-filter" aria-hidden="true"></i> Clear all selections</button>
			<p style="text-align:center;">Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the default time range.</p>
		</div>
		
		<div class="d3_question_header">
		</div>
		<div id="reinfection_table">
			<p>&nbsp;</p>
			<div class="col-xs-2">&nbsp;</div>
			<div class="col-xs-8" id="reinfections-by-date"></div>
			<jsp:include page="../tables/reinfections_by_date.jsp"/>
		</div>
	</div>
		
</div>
