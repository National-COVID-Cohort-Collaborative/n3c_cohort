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
             <ul class="nav nav-tabs" style="font-size: 16px;">
                <li class="active"><a data-toggle="tab" href="#ph-summary">Summary Data</a></li>
                <li><a data-toggle="tab" href="#ph-pediatrics">Pediatrics</a></li>
                <li><a data-toggle="tab" href="#ph-long-covid">Long COVID</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="ph-summary">
                    <jsp:include page="questions2.jsp" flush="true" />
                </div>
                <div class="tab-pane fade" id="ph-pediatrics">
                    <jsp:include page="pediatrics.jsp" flush="true" />
                </div>
                <div class="tab-pane fade" id="ph-long-covid">
                    <jsp:include page="long_covid.jsp" flush="true" />
                </div>
            </div>
        </div>
    </div>
</div>
