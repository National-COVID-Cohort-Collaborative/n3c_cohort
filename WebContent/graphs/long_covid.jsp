<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.long_nav a {
    	cursor: pointer;
	}

	.long_nav .long_nav_item:not(.long_nav_row_selected):hover{
		background-color: #f5f5f5;
	}
	
	.long_nav_row_selected{
	    background: #337ab7;
		padding-top: 10px;
    	padding-bottom: 10px;
    	padding-left: 10px;
    	color: #fff;
	}
	.long_nav_row_selected > a { color:#fff;};
	.long_nav_item{
		border-top:1px solid lightgray;
		padding-top: 10px;
    	padding-bottom: 10px;
    	padding-left: 10px;
    	color: #376076;
	}
</style>

<div class="row">
	<div class="col-xs-12 col-lg-2">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<h4>Visualizations</h4>
				<div class="long_nav">
					<div class="long_nav_item long_nav_row_selected cards2" id="long-covid-menu4">
						<h5><a onclick="thelongclick.call(this); long_covid_render('long-covid-4-tile')">Figure 4</a></h5>
					</div>
					<div class="long_nav_item cards2" id="long-covid-menu2">
						<h5><a onclick="thelongclick.call(this); long_covid_render('long-covid-2-tile')">Figure 2</a></h5>
					</div>
					<div class="long_nav_item cards2" id="long-covid-menus1">
						<h5><a onclick="thelongclick.call(this); long_covid_render('long-covid-s1-tile')">Figures 1 and S1</a></h5>
					</div>
					<div class="long_nav_item cards2" id="long-covid-menus5">
						<h5><a onclick="thelongclick.call(this); long_covid_render('long-covid-t1-tile')">Table 1</a></h5>
					</div>
					<div class="long_nav_item cards2" id="long-covid-menus6">
						<h5><a onclick="thelongclick.call(this); long_covid_render('long-covid-t2-tile')">Table 2</a></h5>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-lg-10 viz-col">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<div id="long-covid-1-tile">
				</div>
				<div id="long-covid-4-tile" style="display:block;">
					<h4 class="centered">Figure 4</h4>
					<jsp:include page="../long_covid_downloads/fig4.jsp"/>
				</div>
				<div id="long-covid-2-tile" style="display:none;">
					<h4 class="centered">Figure 2</h4>
					<a href="long_covid_downloads/fig2.svg"><img alt="test image" src="long_covid_downloads/fig2.svg" width="100%"></a>
				</div>
				<div id="long-covid-s1-tile" style="display:none;">
					<h4 class="centered">Figure 1</h4>
					<a href="long_covid_downloads/fig1.svg"><img alt="test image" src="long_covid_downloads/fig1.svg" width="100%"></a>
					<h4 class="centered">Figure S1</h4>
					<a href="long_covid_downloads/figS1.svg"><img alt="test image" src="long_covid_downloads/figS1.svg" width="100%"></a>
				</div>
				<div id="long-covid-t1-tile" style="display:none;">
					<h4 class="centered">Table 1</h4>
					<c:import url="../long_covid_downloads/table1.html"/>
				</div>
				<div id="long-covid-t2-tile" style="display:none;">
					<h4 class="centered">Table 2</h4>
					<c:import url="../long_covid_downloads/table2.html"/>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
var thelongclick = function(){
	$(".long_nav .long_nav_item").removeClass('long_nav_row_selected');        
    $(this).closest( ".long_nav_item" ).addClass('long_nav_row_selected');
};

function long_covid_render(facet) {
	if (facet == "long-covid-1-tile") {
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "none";
		document.getElementById("long-covid-t1-tile").style.display = "none";
		document.getElementById("long-covid-t2-tile").style.display = "none";
	}
	if (facet == "long-covid-2-tile") {
		document.getElementById("long-covid-2-tile").style.display = "block";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "none";
		document.getElementById("long-covid-t1-tile").style.display = "none";
		document.getElementById("long-covid-t2-tile").style.display = "none";
	}
	if (facet == "long-covid-3-tile") {
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "none";
		document.getElementById("long-covid-t1-tile").style.display = "none";
		document.getElementById("long-covid-t2-tile").style.display = "none";
	}
	if (facet == "long-covid-4-tile") {
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "block";
		document.getElementById("long-covid-s1-tile").style.display = "none";
		document.getElementById("long-covid-t1-tile").style.display = "none";
		document.getElementById("long-covid-t2-tile").style.display = "none";
	}
	if (facet == "long-covid-5-tile") {
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "none";
		document.getElementById("long-covid-t1-tile").style.display = "none";
		document.getElementById("long-covid-t2-tile").style.display = "none";
	}
	if (facet == "long-covid-s1-tile") {
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "block";
		document.getElementById("long-covid-t1-tile").style.display = "none";
		document.getElementById("long-covid-t2-tile").style.display = "none";
	}
	if (facet == "long-covid-t1-tile") {
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "none";
		document.getElementById("long-covid-t1-tile").style.display = "block";
		document.getElementById("long-covid-t2-tile").style.display = "none";
	}
	if (facet == "long-covid-t2-tile") {
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "none";
		document.getElementById("long-covid-t1-tile").style.display = "none";
		document.getElementById("long-covid-t2-tile").style.display = "block";
	}
}
</script>