<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" flush="true" />


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
			case "questions":
				pageContext.setAttribute("active_tab", "questions");
				break;
			case "demo1":
				pageContext.setAttribute("active_tab", "demo1");
				break;
			case "collaboration":
				pageContext.setAttribute("active_tab", "collaboration");
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
		<div class="row" style="margin: auto; padding-left: 10%; padding-right: 10%; font-size: 16px;">
			<jsp:include page="caption.jsp">
				<jsp:param value="dashboard-header" name="tag" />
			</jsp:include>
		</div>
		<p>&nbsp;</p>
		<ul class="nav nav-tabs" id="maintabs" style="font-size: 16px;">
			<li <c:if test="${active_tab =='dashboard'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="graphs/dashboard.jsp" href="#dashboard">The Cohort</a>
			</li>
			<li <c:if test="${active_tab =='collaborative'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="graphs/collaborative.jsp" href="#collaborative">The Collaborative</a>
			</li>
			<li <c:if test="${active_tab =='pubs'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="graphs/publications.jsp" href="#pubs">Publications</a>
			</li>
			<li <c:if test="${active_tab =='questions'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="graphs/public_health.jsp" href="#questions">Public Health</a>
			</li>
			<li <c:if test="${active_tab =='demo1'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="demo1/dashboard.jsp" href="#demo1">Demo 1</a>
			</li>
			<li <c:if test="${active_tab =='collaboration'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="graphs/collaboration.jsp" href="#collaboration">Enclave Collaboration</a>
			</li>
		</ul>

		<div class="tab-content" id="maintabscontent">
			<div class="tab-pane fade <c:if test="${active_tab =='dashboard'}">in active</c:if>" id="dashboard"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='collaborative'}">in active</c:if>" id="collaborative"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='pubs'}">in active</c:if>" id="pubs"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='questions'}">in active</c:if>" id="questions"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='demo1'}">in active</c:if>" id="demo1"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='collaboration'}">in active</c:if>" id="collaboration"></div>
		</div>
		<jsp:include page="footer.jsp" flush="true" />
	</div>
	<script>
		var crumbs = '#${active_tab}';

		$(function() {

			$('.nav-tabs a').each(function(index, el) {

				var $this = $(this);
				var pane = $this.attr('href');
				var which = $this.data('src');

				if (pane == '#${active_tab}')
					$(pane).load(which);

			});

		});

		$('.nav-tabs').on('click', 'a', function(e) {
			e.preventDefault();

			var $this = $(this);
			var pane = $this.attr('href');
			var which = $this.data('src');

			if (!crumbs.includes(pane)) {
				$(pane).load(which);
				crumbs = crumbs + pane;
				console.log({
					pane : pane,
					which : which
				});
			}
		});
	</script>
</body>



</html>


