<div class="row">
    <div class="col-xs-12">
        <div class="panel panel-primary top_panel shadow-border">
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
