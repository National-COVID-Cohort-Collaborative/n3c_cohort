<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" flush="true" />


<style type="text/css" media="all">
@import "resources/n3c_login_style.css";
</style>

<style type="text/css">
table.dataTable thead .sorting_asc {
	background-image: none !important;
}
</style>

<body>

	<jsp:include page="navbar.jsp" flush="true" />

	<div class="container-fluid">
		<h2 class="header-text">
			<img src="images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">N3C Cohort Exploration
		</h2>
		<div style="text-align: center;">
			This is an initial configuration of an exploration tool for the N3C
			cohort data.<br> You are encouraged to submit suggestions for
			enhancements/additions to <a href="https://n3c-help.atlassian.net/jira/software/c/projects/N3CINTA/issues/N3CINTA-4">this
				tracking issue.</a>
		</div>
		<p>&nbsp;</p>
		<ul class="nav nav-tabs lazyload" style="font-size: 16px;">
			<li class="active"><a data-toggle="tab" href="#home">Home</a></li>
			<li><a data-toggle="tab" href="#characteristics">Characteristics</a></li>
			<li><a data-toggle="tab" href="#blood">Blood Type</a></li>
			<li><a data-toggle="tab" href="#charlson">Charlson</a></li>
			<li><a data-toggle="tab" href="#medications">Medications</a></li>
			<li><a data-toggle="tab" href="#labs">Labs</a></li>
			<li><a data-toggle="tab" href="#severity">Severity</a></li>
			<li><a data-toggle="tab" href="#scatter">Scatter Plots</a></li>
			<li><a data-toggle="tab" href="#tables">Tables</a></li>
		</ul>

		<div class="tab-content">
			<div class="tab-pane fade in active" id="home">
				<jsp:include page="graphs/home.jsp" flush="true" />
			</div>
			
			<div class="tab-pane fade" id="tables">
				<jsp:include page="graphs/tables.jsp" flush="true" />
			</div>

			<div class="tab-pane fade" id="blood">
				<jsp:include page="graphs/blood.jsp" flush="true" />
			</div>
			<div class="tab-pane fade" id="characteristics">
				<jsp:include page="graphs/characteristics.jsp" flush="true" />
			</div>
			<div class="tab-pane fade" id="charlson">
				<jsp:include page="graphs/charlson.jsp" flush="true" />
			</div>
			<div class="tab-pane fade" id="medications">
				<jsp:include page="graphs/medications.jsp" flush="true" />
			</div>
			<div class="tab-pane fade" id="labs">
				<jsp:include page="graphs/labs.jsp" flush="true" />
			</div>
			<div class="tab-pane fade" id="severity">
				<jsp:include page="graphs/severity.jsp" flush="true" />
			</div>
			<div class="tab-pane fade" id="scatter">
				<jsp:include page="graphs/scatter.jsp" flush="true" />
			</div>
			<div class="tab-pane fade" id="tables">
				<jsp:include page="graphs/tables.jsp" flush="true" />
			</div>
		</div>

		<jsp:include page="footer.jsp" flush="true" />
	</div>
</body>
</html>
