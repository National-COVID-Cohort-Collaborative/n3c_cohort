<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row">
	<div class="col-xs-12 centered">
		<h3>COVID-19 Age Distributions over Time - All Patients</h3>
		<c:import url="https://covid.cd2h.org/pediatrics-dashboard/release_date.jsp"/>
		<p>Click on an image to zoom.</p>
	</div>
	<div class="col-xs-12 col-md-6">
		<h4 class="centered">Pediatrics</h4>
		<a href="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_all_pcrag.svg"><img alt="test image" src="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_all_pcrag.svg" width="100%"></a>
	</div>
	<div class="col-xs-12 col-md-6">
		<h4 class="centered">Adult</h4>
		<a href="https://covid.cd2h.org/pediatrics-dashboard/downloads/adult_all_pcrag.svg"><img alt="test image" src="https://covid.cd2h.org/pediatrics-dashboard/downloads/adult_all_pcrag.svg" width="100%"></a>
	</div>
	<div class="col-xs-12">&nbsp;</div>
		<div class="col-xs-3">&nbsp;</div>
		<div class="col-xs-6">
			<c:import url="https://covid.cd2h.org/pediatrics-dashboard/caption.jsp?tag=age_all"/>
		</div>
</div>
	
<div class="row section_spacing">
	<div class="col-xs-12 centered">
		<h3>COVID-19 Age Distributions over Time - Hospitalized Patients</h3>
		<p>Click on an image to zoom.</p>
	</div>
	
	<div class="col-xs-12 col-md-6">
		<h4 class="centered">Pediatrics</h4>
		<a href="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_hosp_pcragab.svg"><img alt="test image" src="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_hosp_pcragab.svg" width="100%"></a>
	</div>
	<div class="col-xs-12 col-md-6">
		<h4 class="centered">Adult</h4>
		<a href="https://covid.cd2h.org/pediatrics-dashboard/downloads/adult_hosp_pcrag.svg"><img alt="test image" src="https://covid.cd2h.org/pediatrics-dashboard/downloads/adult_hosp_pcrag.svg" width="100%"></a>
	</div>
	<div class="col-xs-12">
		<div class="col-xs-3">&nbsp;</div>
		<div class="col-xs-6">
			<c:import url="https://covid.cd2h.org/pediatrics-dashboard/caption.jsp?tag=age_hospitalized"/>
		</div>
	</div>
</div>

<div class="row section_spacing">
	<div class="col-xs-12 col-md-6" style="margin:auto;">
		<div class="centered">
			<h3>Pediatrics - Antibody Positive Only</h3>
			<p>Click on an image to zoom.</p>
		</div>
		<a href="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_hosp_ab.svg"><img alt="test image" src="https://covid.cd2h.org/pediatrics-dashboard/downloads/peds_hosp_ab.svg" width="100%"></a>
		<c:import url="https://covid.cd2h.org/pediatrics-dashboard/caption.jsp?tag=age_antibody"/>
	</div>
</div>
