<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	.peds_nav a {
    	cursor: pointer;
	}
	.row_selected{
		background: lightgray;
	}
	.peds_nav_item{
		border-top:1px solid lightgray;
		padding-top: 10px;
    	padding-bottom: 10px;
    	padding-left: 10px;
	}
	.centered{
		text-align:center;
	}
	.section_spacing{
		margin-top:50px;
	}
</style>

<div class="row">
	<div class="col-xs-12 col-lg-2">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<h4>Visualizations</h4>
				<div class="peds_nav">
					<div class="peds_nav_item row_selected" id="pediatrics-menu1">
						<h5><a onclick="thepedsclick.call(this); pediatrics_render('pediatrics-severity-tile')">Severity Distributions over Time</a></h5>
					</div>

					<div class="peds_nav_item" id="pediatrics-menu2">
						<h5><a onclick="thepedsclick.call(this); pediatrics_render('pediatrics-age-tile')">Age Distributions over Time</a></h5>
					</div>
					<div class="peds_nav_item" id="pediatrics-menu3">
						<h5><a onclick="thepedsclick.call(this); pediatrics_render('pediatrics-coinfection-tile')">Viral Coinfection</a></h5>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="col-xs-12 col-lg-10">
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
var thepedsclick = function(){
	$(".peds_nav .peds_nav_item").removeClass('row_selected');        
    $(this).closest( ".peds_nav_item" ).addClass('row_selected');
};

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