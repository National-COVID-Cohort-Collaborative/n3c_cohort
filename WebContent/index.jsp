<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" flush="true" />


<style type="text/css" media="all">
@import "<util:applicationRoot/>/resources/n3c_login_style.css";
@import "<util:applicationRoot/>/resources/main_style.css";
</style>

<style type="text/css">
table.dataTable thead .sorting_asc {
	background-image: none !important;
}
</style>

<body>

	<jsp:include page="navbar.jsp" flush="true" />

	<c:choose>
		<c:when test="${param.main == 'cohort' }">
			<c:set var="active_tab" value="cohort" />
			<script>
				history.pushState(null, '', "<util:applicationRoot/>/cohort")
			</script>
		</c:when>
		<c:when test="${param.main == 'collaborative' }">
			<c:set var="active_tab" value="collaborative" />
			<script>
				history.pushState(null, '', "<util:applicationRoot/>/collaborative")
			</script>
		</c:when>
		<c:when test="${param.main == 'public-health' }">
			<c:set var="active_tab" value="public-health" />
			<script>
				history.pushState(null, '', "<util:applicationRoot/>/public-health")
			</script>
		</c:when>
		<c:when test="${param.main == 'long-covid' }">
			<c:set var="active_tab" value="long-covid" />
			<script>
				history.pushState(null, '', "<util:applicationRoot/>/long-covid")
			</script>
		</c:when>
		<c:when test="${param.main == 'demo1' }">
			<c:set var="active_tab" value="demo1" />
			<script>
				history.pushState(null, '', "<util:applicationRoot/>/demo1")
			</script>
		</c:when>
		<c:when test="${param.main == 'publications' }">
			<c:set var="active_tab" value="publications" />
			<script>
				history.pushState(null, '', "<util:applicationRoot/>/publications")
			</script>
		</c:when>
		<c:when test="${param.main == 'collaboration' }">
			<c:set var="active_tab" value="collaboration" />
			<script>
				history.pushState(null, '', "<util:applicationRoot/>/collaboration")
			</script>
		</c:when>
		<c:otherwise>
			<c:set var="active_tab" value="cohort" />
			<script>
				history.pushState(null, '', "cohort")
			</script>
		</c:otherwise>
	</c:choose>
	
	<div class="container-fluid">
		<h2 class="header-text">
			<img src="<util:applicationRoot/>/images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">N3C
			Cohort Exploration
		</h2>
		<div class="row" style="margin: auto; padding-left: 10%; padding-right: 10%; font-size: 16px;">
			<jsp:include page="caption.jsp">
				<jsp:param value="dashboard-header" name="tag" />
			</jsp:include>
		</div>
		<p>&nbsp;</p>
		<ul class="nav nav-tabs main-tab" id="maintabs" style="font-size: 16px;">
			<li <c:if test="${active_tab =='cohort'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="graphs/dashboard.jsp" href="#cohort">The Cohort</a>
			</li>
			<li <c:if test="${active_tab =='collaborative'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="graphs/collaborative.jsp" href="#collaborative">The Collaborative</a>
			</li>
			<li <c:if test="${active_tab =='publications'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="graphs/publications.jsp" href="#publications">Publications</a>
			</li>
			<li <c:if test="${active_tab =='public-health'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="<util:applicationRoot/>/graphs/public_health.jsp?secondary_tab=${param.secondary}&tertiary_tab=${param.tertiary}" href="#public-health">Public Health</a>
			</li>
			<li <c:if test="${active_tab =='long-covid'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="graphs/long_covid.jsp?secondary_tab=${param.secondary}" href="#long-covid">Long-COVID</a>
			</li>
			<li <c:if test="${active_tab =='demo1'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="demo1/dashboard.jsp" href="#demo1">Demo 1</a>
			</li>
			<li <c:if test="${active_tab =='collaboration'}">class="active"</c:if>>
				<a data-toggle="tab" data-src="graphs/collaboration.jsp" href="#collaboration">Enclave Collaboration</a>
			</li>
		</ul>

		<div class="tab-content" id="maintabscontent">
			<div class="tab-pane fade <c:if test="${active_tab =='cohort'}">in active</c:if>" id="cohort"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='collaborative'}">in active</c:if>" id="collaborative"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='publications'}">in active</c:if>" id="publications"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='public-health'}">in active</c:if>" id="public-health"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='long-covid'}">in active</c:if>" id="long-covid"></div>
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

		$('.main-tab').on('click', 'a', function(e) {
			e.preventDefault();

			var $this = $(this);
			var pane = $this.attr('href');
			var which = $this.data('src');

			console.log("in click", pane)
			history.pushState(null, '', '<util:applicationRoot/>/'+pane.substring(1))
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


