<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
	.peds_nav a {
    	cursor: pointer;
	}
	
	.peds_nav .peds_nav_item:not(.peds_nav_row_selected):hover{
		background-color: #f5f5f5;
	}
	
	.peds_nav_row_selected{
	    background: #337ab7;
		padding-top: 10px;
    	padding-bottom: 10px;
    	padding-left: 10px;
    	color: #fff;
	}
	.peds_nav_row_selected > a { color:#fff;};
	.peds_nav_item{
		border-top:1px solid lightgray;
		padding-top: 10px;
    	padding-bottom: 10px;
    	padding-left: 10px;
    	color: #376076;
	}
	.centered{
		text-align:center;
	}
	.section_spacing{
		margin-top:50px;
	}

.cards2 {
	float: left;
	width: 100%;
	margin: 0.5rem;
	border: 0.0625rem solid rgba(0, 0, 0, .125);
	border-radius: .25rem;
	box-shadow: 0.25rem 0.25rem 0.5rem rgba(0, 0, 0, 0.25);
		padding-top: 10px;
    	padding-bottom: 10px;
    	padding-left: 10px;
}
</style>

<c:choose>
	<c:when test="${empty param.tertiary_tab || param.tertiary_tab == 'severity'}">
		<c:set var="active_tab" value="severity"/>
	</c:when>
	<c:when test="${param.tertiary_tab == 'age'}">
		<c:set var="active_tab" value="age"/>
	</c:when>
	<c:when test="${param.tertiary_tab == 'coinfection'}">
		<c:set var="active_tab" value="coinfection"/>
	</c:when>
	<c:when test="${param.tertiary_tab == 'geographic'}">
		<c:set var="active_tab" value="geographic"/>
	</c:when>
	<c:otherwise>
		<c:set var="active_tab" value="severity"/>
	</c:otherwise>
</c:choose>

<div class="row">
	<div class="col-xs-12 col-lg-2">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<h4>Visualizations ${param.tertiary_tab }</h4>
				<div class="peds_nav">
					<div class="peds_nav_item cards2 <c:if test="${active_tab == 'severity' }">peds_nav_row_selected</c:if>" id="pediatrics-menu1">
						<h5><a onclick="thepedsclick.call(this); pediatrics_render('pediatrics-severity-tile')">Severity Distributions over Time</a></h5>
					</div>

					<div class="peds_nav_item cards2 <c:if test="${active_tab == 'age' }">peds_nav_row_selected</c:if>" id="pediatrics-menu2">
						<h5><a onclick="thepedsclick.call(this); pediatrics_render('pediatrics-age-tile')">Age Distributions over Time</a></h5>
					</div>
					<div class="peds_nav_item cards2 <c:if test="${active_tab == 'coinfection' }">peds_nav_row_selected</c:if>" id="pediatrics-menu3">
						<h5><a onclick="thepedsclick.call(this); pediatrics_render('pediatrics-coinfection-tile')">Viral Coinfection</a></h5>
					</div>
					<div class="peds_nav_item cards2 <c:if test="${active_tab == 'geographic' }">peds_nav_row_selected</c:if>" id="pediatrics-menu4">
						<h5><a onclick="thepedsclick.call(this); pediatrics_render('pediatrics-geographic-tile')">Geographic Distribution</a></h5>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="col-xs-12 col-lg-10 viz-col">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<div id="pediatrics-severity-tile" <c:if test="${active_tab != 'severity' }">style="display:none;"</c:if>>
					<c:if test="${active_tab == 'severity' }">
 						<script>
							cache_browser_history("public-health", "public-health/pediatrics/severity")
						</script>
 					</c:if>
 					<jsp:include page="pediatrics_severity.jsp"/>
				</div>
				<div id="pediatrics-age-tile" <c:if test="${active_tab != 'age' }">style="display:none;"</c:if>">
					<c:if test="${active_tab == 'age' }">
 						<script>
							cache_browser_history("public-health", "public-health/pediatrics/age")
						</script>
 					</c:if>
					<jsp:include page="pediatrics_age.jsp"/>
				</div>
				<div id="pediatrics-coinfection-tile" <c:if test="${active_tab != 'coinfection' }">style="display:none;"</c:if>>
					<c:if test="${active_tab == 'coinfection' }">
 						<script>
							cache_browser_history("public-health", "public-health/pediatrics/coinfection")
						</script>
 					</c:if>
					<jsp:include page="pediatrics_coinfection.jsp"/>
				</div>
				<div id="pediatrics-geographic-tile" <c:if test="${active_tab != 'geographic' }">style="display:none;"</c:if>>
					<c:if test="${active_tab == 'geographic' }">
 						<script>
							cache_browser_history("public-health", "public-health/pediatrics/geographic")
						</script>
 					</c:if>
					<jsp:include page="pediatrics_geographic.jsp"/>
				</div>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-lg-10 viz-col">
		<div class="col-xs-3">&nbsp;</div>
		<div class="col-xs-8">
			<p class="text-center font-weight-lighter pr-0 pb-0 mb-1" style="font-size:10pt;">This work is supported by the National Institutes of Health's 
			Eunice Kennedy Shriver National Institute of Child Health and Human Development (NICHD) Grant number 3R01HD105939-01S1
			and the National Center for Advancing Translational Sciences,
			Grant Number U24TR002306. This work is solely the responsibility of the creators and does not necessarily represent
			the official views of the National Institutes of Health.</p>
			</div>
	</div>
</div>
<script>
var thepedsclick = function(){
	$(".peds_nav .peds_nav_item").removeClass('peds_nav_row_selected');        
    $(this).closest( ".peds_nav_item" ).addClass('peds_nav_row_selected');
};

function pediatrics_render(facet) {
	if (facet == "pediatrics-severity-tile") {
		document.getElementById("pediatrics-severity-tile").style.display = "block";
		document.getElementById("pediatrics-age-tile").style.display = "none";
		document.getElementById("pediatrics-coinfection-tile").style.display = "none";
		document.getElementById("pediatrics-geographic-tile").style.display = "none";
		
		cache_browser_history("public-health", "public-health/pediatrics/severity")
	}
	if (facet == "pediatrics-age-tile") {
		document.getElementById("pediatrics-severity-tile").style.display = "none";
		document.getElementById("pediatrics-age-tile").style.display = "block";
		document.getElementById("pediatrics-coinfection-tile").style.display = "none";
		document.getElementById("pediatrics-geographic-tile").style.display = "none";
		
		cache_browser_history("public-health", "public-health/pediatrics/age")
	}
	if (facet == "pediatrics-coinfection-tile") {
		document.getElementById("pediatrics-severity-tile").style.display = "none";
		document.getElementById("pediatrics-age-tile").style.display = "none";
		document.getElementById("pediatrics-coinfection-tile").style.display = "block";
		document.getElementById("pediatrics-geographic-tile").style.display = "none";
		
		cache_browser_history("public-health", "public-health/pediatrics/coinfection")
	}
	if (facet == "pediatrics-geographic-tile") {
		document.getElementById("pediatrics-severity-tile").style.display = "none";
		document.getElementById("pediatrics-age-tile").style.display = "none";
		document.getElementById("pediatrics-coinfection-tile").style.display = "none";
		document.getElementById("pediatrics-geographic-tile").style.display = "block";
		
		cache_browser_history("public-health", "public-health/pediatrics/geographic")
	}
}
</script>