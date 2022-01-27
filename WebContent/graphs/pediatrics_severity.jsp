<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="col-xs-12 centered">
		<h3>COVID-19 Disease Severity over Time</h3>
		<c:import url="https://covid.cd2h.org/pediatrics-dashboard/release_date.jsp"/>
		<p>Click on an image to zoom.</p>
	</div>
	<div class="col-xs-12, col-md-6">
		<h4 class="centered">Pediatrics</h4>
		<a href="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_all_severity.svg"><img alt="test image"
			src="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_all_severity.svg" width="100%"></a>
	</div>
	<div class="col-xs-12, col-md-6">
		<h4 class="centered">Adult</h4>
		<a href="https://covid.cd2h.org/pediatrics-dashboard/downloads/adult_all_severity.svg"><img alt="test image"
			src="https://covid.cd2h.org/pediatrics-dashboard/downloads/adult_all_severity.svg" width="100%"></a>
	</div>
	<div class="col-xs-6 centered">
		<c:import url="https://covid.cd2h.org/pediatrics-dashboard/caption.jsp?tag=severity"/>
	</div>
	<div class="col-xs-12 centered">
	<div class="col-xs-2">&nbsp;</div>
	<div class="col-xs-8">
		<h4>Vasoactive and Mechanical Ventilation</h4>
		<a href="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_whysevere.svg"><img alt="test image"
			src="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_whysevere.svg" width="100%"></a>
	</div>
	<div class="col-xs-3">&nbsp;</div>
	<div class="col-xs-6">
		<c:import url="https://covid.cd2h.org/pediatrics-dashboard/caption.jsp?tag=severity_reason"/>
	</div>
	</div>
