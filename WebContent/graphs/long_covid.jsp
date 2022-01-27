<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row comor">
	<div class="col-xs-2">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<h4>Visualizations</h4>
				<hr>
				<div id="long-covid-menu1">
					<h5><a onclick="long_covid_render('long-covid-1-tile')">Figure 1</a></h5>
				</div>
				<hr>
				<div id="long-covid-menu2">
					<h5><a onclick="long_covid_render('long-covid-2-tile')">Figure 2</a></h5>
				</div>
				<hr>
				<div id="long-covid-menu3">
					<h5><a onclick="long_covid_render('long-covid-3-tile')">Figure 3</a></h5>
				</div>
				<hr>
				<div id="long-covid-menu4">
					<h5><a onclick="long_covid_render('long-covid-4-tile')">Figure 4</a></h5>
				</div>
				<hr>
				<div id="long-covid-menu5">
					<h5><a onclick="long_covid_render('long-covid-5-tile')">Figure 5</a></h5>
				</div>
				<hr>
				<div id="long-covid-menus1">
					<h5><a onclick="long_covid_render('long-covid-s1-tile')">Figure S1</a></h5>
				</div>
			</div>
		</div>
	</div>
	<div class="col-xs-10">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<div id="long-covid-1-tile">
					<h4 class="centered">Figure 1</h4>
					<a href="long_covid_downloads/fig1.svg"><img alt="test image" src="long_covid_downloads/fig1.svg" width="100%"></a>
				</div>
				<div id="long-covid-2-tile" style="display:none;">
					<h4 class="centered">Figure 2</h4>
					<a href="long_covid_downloads/fig2.svg"><img alt="test image" src="long_covid_downloads/fig2.svg" width="100%"></a>
				</div>
				<div id="long-covid-3-tile" style="display:none;">
					<h4 class="centered">Figure 3</h4>
					<a href="long_covid_downloads/fig3.svg"><img alt="test image" src="long_covid_downloads/fig3.svg" width="100%"></a>
				</div>
				<div id="long-covid-4-tile">
					<h4 class="centered">Figure 4</h4>
					<a href="long_covid_downloads/fig4.svg"><img alt="test image" src="long_covid_downloads/fig4.svg" width="100%"></a>
				</div>
				<div id="long-covid-5-tile" style="display:none;">
					<h4 class="centered">Figure 5</h4>
					<a href="long_covid_downloads/fig5.svg"><img alt="test image" src="long_covid_downloads/fig5.svg" width="100%"></a>
				</div>
				<div id="long-covid-s1-tile" style="display:none;">
					<h4 class="centered">Figure S1</h4>
					<a href="long_covid_downloads/figS1.svg"><img alt="test image" src="long_covid_downloads/figS1.svg" width="100%"></a>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
function long_covid_render(facet) {
	if (facet == "long-covid-1-tile") {
		document.getElementById("long-covid-1-tile").style.display = "block";
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-3-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-5-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "none";
	}
	if (facet == "long-covid-2-tile") {
		document.getElementById("long-covid-1-tile").style.display = "none";
		document.getElementById("long-covid-2-tile").style.display = "block";
		document.getElementById("long-covid-3-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-5-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "none";
	}
	if (facet == "long-covid-3-tile") {
		document.getElementById("long-covid-1-tile").style.display = "none";
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-3-tile").style.display = "block";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-5-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "none";
	}
	if (facet == "long-covid-4-tile") {
		document.getElementById("long-covid-1-tile").style.display = "none";
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-3-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "block";
		document.getElementById("long-covid-5-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "none";
	}
	if (facet == "long-covid-5-tile") {
		document.getElementById("long-covid-1-tile").style.display = "none";
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-3-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-5-tile").style.display = "block";
		document.getElementById("long-covid-s1-tile").style.display = "none";
	}
	if (facet == "long-covid-s1-tile") {
		document.getElementById("long-covid-1-tile").style.display = "none";
		document.getElementById("long-covid-2-tile").style.display = "none";
		document.getElementById("long-covid-3-tile").style.display = "none";
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-5-tile").style.display = "none";
		document.getElementById("long-covid-s1-tile").style.display = "block";
	}
}
</script>