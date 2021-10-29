<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" flush="true" />

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script src="resources/MT.BootstrapLazyloader.js"></script>
	<link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet">
	<script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>

<script src="resources/d3.v4.min.js"></script>
<script src="resources/d3-tip.js"></script>

<style type="text/css" media="all">
@import "resources/n3c_login_style.css";
@import "resources/main_style.css";
</style>

<style type="text/css">
table.dataTable thead .sorting_asc {
	background-image: none !important;
}
</style>

<body>

	<jsp:include page="navbar.jsp" flush="true" />

	<c:set var="active_tab" value="dashboard"/>
	<%  /* valueless parameters are not visible at the JSTL/EL level, so we do some scriptlet magic */
		java.util.Enumeration names = request.getParameterNames();
		while (names.hasMoreElements()) {
			switch((String)names.nextElement()) {
			case "publications":
				pageContext.setAttribute("active_tab", "pubs");
				break;
			case "collaborative":
				pageContext.setAttribute("active_tab", "collaborative");
				break;
			case "clinical":
				pageContext.setAttribute("active_tab", "clinical");
				break;
			case "ml":
				pageContext.setAttribute("active_tab", "ml");
				break;
			case "phenotype":
				pageContext.setAttribute("active_tab", "pe");
				break;
			case "questions":
				pageContext.setAttribute("active_tab", "questions");
				break;
			case "questions2":
				pageContext.setAttribute("active_tab", "questions2");
				break;
			case "cohort":
			default:
				pageContext.setAttribute("active_tab", "dashboard");
			}
		}
	%>

	<div class="container-fluid">
		<h2 class="header-text">
			<img src="images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">N3C
			Cohort Exploration
		</h2>
		<div class="row"
			style="margin: auto; padding-left: 10%; padding-right: 10%; font-size: 16px;">
			<p>
				<span style="font-size: 20px; font-weight: 500;">Ready to
					dive into the data?</span>&emsp;View and analyze data in our secure N3C
				Data Enclave. The data include harmonized de-identified information
				from electronic health records. The Data Enclave is open to academic
				researchers, clinicians, and citizen scientists. <a
					href="https://covid.cd2h.org/enclave" style="font-weight: 600;">Register
					for an account now!</a>
			</p>

			<p>
				You are encouraged to submit suggestions for enhancements/additions
				to <a
					href="https://n3c-help.atlassian.net/jira/software/c/projects/N3CINTA/issues/N3CINTA-4">this
					tracking issue.</a>
			</p>
		</div>
		<p>&nbsp;</p>
		<ul class="nav nav-tabs" style="font-size: 16px;">
			<li <c:if test="${active_tab =='dashboard'}">class="active"</c:if>><a data-toggle="tab" href="#dashboard">The Cohort</a></li>
			<li <c:if test="${active_tab =='collaborative'}">class="active"</c:if>><a data-toggle="tab" href="#collaborative">The Collaborative</a></li>
			<li <c:if test="${active_tab =='clinical'}">class="active"</c:if>><a data-toggle="tab" href="#clinical">Clinical Details</a></li>
			<li <c:if test="${active_tab =='ml'}">class="active"</c:if>><a data-toggle="tab" href="#ml">Machine Learning Details</a></li>
			<li <c:if test="${active_tab =='pubs'}">class="active"</c:if>><a data-toggle="tab" href="#pubs">Publications</a></li>
			<li <c:if test="${active_tab =='pe'}">class="active"</c:if>><a data-toggle="tab" href="#pe">Phenotype Explorer</a></li>
			<li <c:if test="${active_tab =='questions'}">class="active"</c:if>><a data-toggle="tab" href="#questions">Public Health</a></li>
			<li <c:if test="${active_tab =='questions2'}">class="active"</c:if>><a data-toggle="tab" href="#questions2">Public Health (Tiles)</a></li>
		</ul>

		<div class="tab-content">
			<div class="tab-pane fade <c:if test="${active_tab =='dashboard'}">in active</c:if>" id="dashboard">
				<jsp:include page="graphs/dashboard.jsp" flush="true" />
			</div>
			<div class="tab-pane fade <c:if test="${active_tab =='clinical'}">in active</c:if>" id="clinical">
				<jsp:include page="graphs/clinical.jsp" flush="true" />
			</div>
			<div class="tab-pane fade <c:if test="${active_tab =='ml'}">in active</c:if>" id="ml">
				<jsp:include page="graphs/ml.jsp" flush="true" />
			</div>
			<div class="tab-pane fade <c:if test="${active_tab =='collaborative'}">in active</c:if>" id="collaborative">
				<jsp:include page="graphs/collaborative.jsp" flush="true" />
			</div>
			<div class="tab-pane fade <c:if test="${active_tab =='pubs'}">in active</c:if>" id="pubs">
				<jsp:include page="graphs/publications.jsp" flush="true" />
			</div>
			<div class="tab-pane fade <c:if test="${active_tab =='pe'}">in active</c:if>" id="pe">
				<jsp:include page="graphs/pe.jsp" flush="true" />
			</div>
			<div class="tab-pane fade <c:if test="${active_tab =='questions'}">in active</c:if>" id="questions">
				<jsp:include page="graphs/questions.jsp" flush="true" />
			</div>
			<div class="tab-pane fade <c:if test="${active_tab =='questions2'}">in active</c:if>" id="questions2">
				<jsp:include page="graphs/questions2.jsp" flush="true" />
			</div>
		</div>
		<jsp:include page="footer.jsp" flush="true" />
	</div>
</body>
</html>
