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
		<c:when test="${param.main == 'publications' }">
			<c:set var="active_tab" value="publications" />
			<script>
				history.pushState(null, '', "<util:applicationRoot/>/publications")
			</script>
		</c:when>
		<c:when test="${param.main == 'public-health' }">
			<c:set var="active_tab" value="public-health" />
			<script>
				history.pushState(null, '', "<util:applicationRoot/>/public-health")
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
				<a data-toggle="tab" data-src="<util:applicationRoot/>/graphs/public_health.jsp<c:if test="${active_tab =='public-health'}">?secondary_tab=${param.secondary}&tertiary_tab=${param.tertiary}</c:if>" href="#public-health">Public Health</a>
			</li>
		</ul>

		<div class="tab-content" id="maintabscontent">
			<div class="tab-pane fade <c:if test="${active_tab =='cohort'}">in active</c:if>" id="cohort"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='collaborative'}">in active</c:if>" id="collaborative"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='publications'}">in active</c:if>" id="publications"></div>
			<div class="tab-pane fade <c:if test="${active_tab =='public-health'}">in active</c:if>" id="public-health"></div>
		</div>
		<jsp:include page="footer.jsp" flush="true" />
	</div>
	<script>
		// abstraction to manage a session's state across already visited tabs, subtabs, and direct access URLs
		
		var tab_cache = [ ];
		var secondary_tab_cache = [ ];
		
		function cache_browser_history(tabname, pathname) {
			var index = tab_cache.findIndex(entry => {
				return entry.tabname === tabname;
			});

			if (index == -1) {
				var new_cache_entry = {
						tabname: tabname,
						pathname: pathname
				}
				tab_cache.push(new_cache_entry);
			} else {
				tab_cache[index].pathname = pathname
			}
			var elements = pathname.split("/");
			
			if (elements.length == 3) {
				var secondary_index = secondary_tab_cache.findIndex(entry => {
					return entry.tabname === (tabname + "/" + elements[1]);
				});
				if (secondary_index == -1) {
					var new_cache_entry = {
							tabname: tabname + "/" + elements[1],
							pathname: pathname
					}
					secondary_tab_cache.push(new_cache_entry);
				} else {
					secondary_tab_cache[secondary_index].pathname = pathname
				}
			}
			
			set_browser_history(tabname)
		}
		
		function set_browser_history(tabname) {
			console.log("tab_cache", tabname, tab_cache, secondary_tab_cache)
			var index = tab_cache.findIndex(entry => {
				return entry.tabname === tabname;
			});
		
			if (index == -1) {
				history.pushState(null, '', '<util:applicationRoot/>/'+tabname)
			} else {
				console.log("cache hit", tab_cache[index].pathname)
				if ((tab_cache[index].pathname.match(/\//g) || []).length > 0) {
					//need to check the secondary cache
					var secondary_index = secondary_tab_cache.findIndex(entry => {
						return entry.tabname === tab_cache[index].pathname;
					});
					console.log("secondary index", secondary_index)
					if (secondary_index == -1) {
						history.pushState(null, '', '<util:applicationRoot/>/'+tab_cache[index].pathname)
					} else {
						history.pushState(null, '', '<util:applicationRoot/>/'+secondary_tab_cache[secondary_index].pathname)
					}
				} else
					history.pushState(null, '', '<util:applicationRoot/>/'+tab_cache[index].pathname)
			}
		}
		
		////////////////////////
		
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

			console.log("in main click", pane)
			set_browser_history(pane.substring(1))
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


