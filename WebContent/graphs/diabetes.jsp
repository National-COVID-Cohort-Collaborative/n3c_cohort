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
			Diabetes Mellitus Type 2
		</div>
		<div id="diabetes_type2_detail">
			<jsp:include page="../graph_support/grouped_stacked_bar_vertical.jsp">
				<jsp:param name="data_page" value="feeds/diabetes_t2_detail.jsp" />
				<jsp:param name="dom_element" value="#diabetes_type2_detail" />
			</jsp:include>
		</div>
		<div class="d3_question_header">
			Diabetes Mellitus Type 1
		</div>
		<div id="pos_rolling">
		</div>
		<div class="d3_question_header">
			Patients with Type-1 Diabetes Under the Age of 18
		</div>
		<div id="pos_rolling">
		</div>
		<div class="d3_question_header">
			Patients with Type-2 Diabetes Under the Age of 18
		</div>
		<div id="pos_rolling">
		</div>
		<div class="d3_question_header">
			Patients with Type-1 Diabetes Over the Age of 18
		</div>
		<div id="pos_rolling">
		</div>
		<div class="d3_question_header">
			Patients with Type-2 Diabetes Over the Age of 18
		</div>
		<div id="pos_rolling">
		</div>
	</div>
		
</div>
