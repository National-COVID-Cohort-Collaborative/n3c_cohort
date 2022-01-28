<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row">
	<div class="col-xs-12 centered">
		<h3>COVID-19 Viral Coinfections</h3>
		<c:import url="https://covid.cd2h.org/pediatrics-dashboard/release_date.jsp"/>
		<p>Click on the image to zoom.</p>
	</div>
</div>

<div class="row">
	<div class="col-sm-12 col-md-8" style="margin:auto;">
		<div class="centered">
			<h4 class="centered">Pediatrics</h4>
			<a href="https://covid.cd2h.org/pediatrics-dashboard/downloads/co-infection_static.svg"><img alt="test image" src="https://covid.cd2h.org/pediatrics-dashboard/downloads/co-infection_static.svg" width="100%"></a>
		</div>
		<c:import url="https://covid.cd2h.org/pediatrics-dashboard/caption.jsp?tag=coinfection"/>
	</div>
</div>
	