<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
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
	.centered{
		text-align:center;
	}
	.section_spacing{
		margin-top:50px;
	}

.cards3 {
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

<div class="row large-ques-nav">
	<div class="col-xs-12">
	<div class="">
		<div class="panel-primary shadow-border ">
			<div class="panel-heading">N3C Long-COVID Dashboard</div>
			<div>
				<p>The data dashboards provide interactive views of <i>N3C</i> Research Program participant data. The N3C Long-COVID dashboard provides high value health data for policy makers, and investigators a
					snapshot of the clinical status of Long COVID as well as signal for further investigation within the N3C open science enclave.</p>
				<p>The data shown in the N3C Long-COVID dashboard comes from the N3C enclave, which is the largest collection of real-world data in the USA. The N3C Enclave comes from 69 health care
					institutions, from 49/50 states across the USA, and as of January 2022 consists of over 12 billion rows of clinical information. In addition to the RWD, the N3C enclave has a library of over 30
					external data sets from that vary from mortality, pollution index that can be linked to the clinical data. A full list of available external data sets can be found at
					<a href="https://discovery.biothings.io/dataset?guide=/guide/n3c/dataset">https://discovery.biothings.io/dataset?guide=/guide/n3c/dataset</a>.</p>
				<p>In order to protect participant privacy, the data are de-identified, limited to aggregate counts and summary demographic information, with cell counts &lt;20 not being displayed. For more
					information, please visit our <a href="https://covid.cd2h.org/faq">FAQ</a> page.</p>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-lg-2">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<h4>Visualizations</h4>
				<div class="long_nav">
					<div class="long_nav_item long_nav_row_selected cards3" id="long-covid-menu4">
						<h5><a onclick="thelongclick.call(this); long_covid_render('long-covid-4-tile')">Model Features</a></h5>
					</div>
					<div class="long_nav_item cards3" id="long-covid-menus5">
						<h5><a onclick="thelongclick.call(this); long_covid_render('long-covid-t1-tile')">Training Cohort Characteristics</a></h5>
					</div>
					<div class="long_nav_item cards3" id="long-covid-menus6">
						<h5><a onclick="thelongclick.call(this); long_covid_render('long-covid-t2-tile')">Demographics</a></h5>
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
					<h4 class="centered">Most important model features for predicting visit to a Long-COVID clinic.</h4>
					<jsp:include page="../long_covid_downloads/fig4.jsp"/>
				</div>
				<div id="long-covid-t1-tile" style="display:none;">
					<h4 class="centered">Characteristics of the three-site cohort used for model training and testing.</h4>
					<c:import url="../long_covid_downloads/table1.html"/>
				</div>
				<div id="long-covid-t2-tile" style="display:none;">
					<h4 class="centered">Demographic breakdown of potential Long-COVID patients in the N3C cohort.</h4>
					<c:import url="../long_covid_downloads/table2.html"/>
				</div>
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
	if (facet == "long-covid-4-tile") {
		document.getElementById("long-covid-4-tile").style.display = "block";
		document.getElementById("long-covid-t1-tile").style.display = "none";
		document.getElementById("long-covid-t2-tile").style.display = "none";
	}
	if (facet == "long-covid-t1-tile") {
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-t1-tile").style.display = "block";
		document.getElementById("long-covid-t2-tile").style.display = "none";
	}
	if (facet == "long-covid-t2-tile") {
		document.getElementById("long-covid-4-tile").style.display = "none";
		document.getElementById("long-covid-t1-tile").style.display = "none";
		document.getElementById("long-covid-t2-tile").style.display = "block";
	}
}
</script>