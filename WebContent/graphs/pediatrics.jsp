<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row comor">
	<div class="col-xs-2">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<h4>Visualizations</h4>
				<hr>
				<div id="pediatrics-menu1">
					<h5><a onclick="pediatrics_render('pediatrics-severity-tile')">Severity Distributions over Time</a></h5>
				</div>
				<hr>
				<div id="pediatrics-menu2">
					<h5><a onclick="pediatrics_render('pediatrics-age-tile')">Age Distributions over Time</a></h5>
				</div>
				<hr>
				<div id="pediatrics-menu3">
					<h5><a onclick="pediatrics_render('pediatrics-coinfection-tile')">Viral Coinfection</a></h5>
				</div>
			</div>
		</div>
	</div>
	<div class="col-xs-10">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<div id="pediatrics-severity-tile">
					<jsp:include page="pediatrics_severity.jsp"/>
				</div>
				<div id="pediatrics-age-tile" style="display:none;">
					<jsp:include page="pediatrics_age.jsp"/>
				</div>
				<div id="pediatrics-coinfection-tile" style="display:none;">
					<jsp:include page="pediatrics_coinfection.jsp"/>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
function pediatrics_render(facet) {
	if (facet == "pediatrics-severity-tile") {
		document.getElementById("pediatrics-severity-tile").style.display = "block";
		document.getElementById("pediatrics-age-tile").style.display = "none";
		document.getElementById("pediatrics-coinfection-tile").style.display = "none";
	}
	if (facet == "pediatrics-age-tile") {
		document.getElementById("pediatrics-severity-tile").style.display = "none";
		document.getElementById("pediatrics-age-tile").style.display = "block";
		document.getElementById("pediatrics-coinfection-tile").style.display = "none";
	}
	if (facet == "pediatrics-coinfection-tile") {
		document.getElementById("pediatrics-severity-tile").style.display = "none";
		document.getElementById("pediatrics-age-tile").style.display = "none";
		document.getElementById("pediatrics-coinfection-tile").style.display = "block";
	}
}
</script>