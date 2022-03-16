<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<script src="resources/auth.js"></script>
<style>

	@media (max-width:991px){
		.pubhealth-panel{
			padding: 0px;
		}
	}
</style>

<div class="row large-ques-nav">
	<div class="col-xs-12">
	<div class="">
		<div class="panel-primary shadow-border ">
			<div class="panel-heading">N3C Public Health Browser</div>
			<div>
				<p>The data dashboards provide interactive views of <i>N3C</i> Research Program participant data. The N3C public health browser provides high value health data for policy makers, and investigators a
					snapshot of the clinical status of COVID as well as signal for further investigation within the N3C open science enclave.</p>
				<p>The data shown in the N3C public health browser comes from the N3C enclave, which is the largest collection of real-world data in the USA. The N3C Enclave comes from 69 health care
					institutions, from 49/50 states across the USA, and as of January 2022 consists of over 12 billion rows of clinical information. In addition to the RWD, the N3C enclave has a library of over 30
					external data sets from that vary from mortality, pollution index that can be linked to the clinical data. A full list of available external data sets can be found at
					<a href="https://discovery.biothings.io/dataset?guide=/guide/n3c/dataset">https://discovery.biothings.io/dataset?guide=/guide/n3c/dataset</a>.</p>
				<p>In order to protect participant privacy, the data are de-identified, limited to aggregate counts and summary demographic information, with cell counts &lt;20 not being displayed. For more
					information, please visit our <a href="https://covid.cd2h.org/faq">FAQ</a> page.</p>
			</div>
		</div>
	</div>
    <div class="col-xs-12">
        <div class="pubhealth-panel panel panel-primary top_panel shadow-border">
             <ul class="nav nav-tabs ph-tab" style="font-size: 16px;">
                <li <c:if test="${empty param.secondary_tab || param.secondary_tab == 'summary' }">class="active"</c:if>><a data-toggle="tab" href="#ph-summary">Summary Data</a></li>
                <li <c:if test="${param.secondary_tab == 'pediatrics' }">class="active"</c:if>><a data-toggle="tab" href="#ph-pediatrics">Pediatrics</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade <c:if test="${empty param.secondary_tab || param.secondary_tab == 'summary' }">in active</c:if>" id="ph-summary">
 					<c:if test="${empty param.secondary_tab || param.secondary_tab == 'summary' }">
 						<script>
							history.pushState(null, '', "<util:applicationRoot/>/public-health/summary")
						</script>
 					</c:if>
                    <jsp:include page="questions2.jsp" flush="true" />
                 </div>
                <div class="tab-pane fade <c:if test="${param.secondary_tab == 'pediatrics' }">in active</c:if>" id="ph-pediatrics">
 					<c:if test="${param.secondary_tab == 'pediatrics' }">
 						<script>
							history.pushState(null, '', "<util:applicationRoot/>/public-health/pediatrics")
						</script>
 					</c:if>
                    <jsp:include page="pediatrics.jsp?tertiary_tab=${param.tertiary_tab}" flush="true" />
               </div>
            </div>
        </div>
    </div>
	<script>
		$('.ph-tab').on('click', 'a', function(e) {
			var $this = $(this);
			var pane = $this.attr('href');
			var which = $this.data('src');

			console.log("in click", pane)
			history.pushState(null, '', '<util:applicationRoot/>/public-health/'+pane.substring(4))
		});
	</script>
</div>
