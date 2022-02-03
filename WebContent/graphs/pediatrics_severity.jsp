<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row">
	<div class="col-xs-12 centered">
		<h3>COVID-19 Disease Severity over Time</h3>
		<c:import
			url="https://covid.cd2h.org/pediatrics-dashboard/release_date.jsp" />
		<p>Click on an image to zoom.</p>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-md-6">
		<h4 class="centered">Pediatrics</h4>
		<a
			href="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_all_severity.svg"><img
			alt="test image"
			src="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_all_severity.svg"
			width="100%"></a>
	</div>
	<div class="col-xs-12 col-md-6">
		<h4 class="centered">Adult</h4>
		<a
			href="https://covid.cd2h.org/pediatrics-dashboard/downloads/adult_all_severity.svg"><img
			alt="test image"
			src="https://covid.cd2h.org/pediatrics-dashboard/downloads/adult_all_severity.svg"
			width="100%"></a>
	</div>
	<div class="col-xs-12 centered">
		<h3>Dynamic Versions of the Above</h3>
	</div>
	<div class="col-xs-8, col-md-6">
		<h4 class="centered">Pediatrics</h4>
		<c:import url="https://covid.cd2h.org/pediatrics-dashboard/plotly/peds_all_severity.html" />
	</div>
	<div class="col-xs-8, col-md-6">
		<h4 class="centered">Adult</h4>
		<c:import url="https://covid.cd2h.org/pediatrics-dashboard/plotly/adult_all_severity.html" />
	</div>
	<div class="col-xs-12">
		<div class="col-xs-3">&nbsp;</div>
		<div class="col-xs-6">
			<c:import url="https://covid.cd2h.org/pediatrics-dashboard/caption.jsp?tag=severity" />
		</div>
	</div>
</div>

<div class="row section_spacing">
	<div class="col-xs-12 col-md-8" style="margin: auto;">
		<div class="centered">
			<h4>Vasoactive and Mechanical Ventilation</h4>
			<a
				href="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_whysevere.svg"><img
				alt="test image"
				src="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_whysevere.svg"
				width="100%"></a>
		</div>
		<c:import
			url="https://covid.cd2h.org/pediatrics-dashboard/caption.jsp?tag=severity_reason" />
	</div>
</div>
