<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row">
	<div class="col-xs-12 centered">
		<h3>Geographic Distribution of Children with COVID-19 in N3C</h3>
		<c:import
			url="https://covid.cd2h.org/pediatrics-dashboard/release_date.jsp" />
		<p>Click on an image to zoom.</p>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-md-6">
		<a
			href="https://covid.cd2h.org/pediatrics-dashboard/downloads/map_peds_all.svg"><img
			alt="test image"
			src="https://covid.cd2h.org/pediatrics-dashboard/downloads/map_peds_all.svg"
			width="100%"></a>
	</div>
	<div class="col-xs-12 col-md-6">
		<a
			href="https://covid.cd2h.org/pediatrics-dashboard/downloads/map_peds_hosp.svg"><img
			alt="test image"
			src="https://covid.cd2h.org/pediatrics-dashboard/downloads/map_peds_hosp.svg"
			width="100%"></a>
	</div>
	<div class="col-xs-12">
		<div class="col-xs-3">&nbsp;</div>
		<div class="col-xs-6">
			<c:import url="https://covid.cd2h.org/pediatrics-dashboard/caption.jsp?tag=map" />
		</div>
	</div>
</div>
