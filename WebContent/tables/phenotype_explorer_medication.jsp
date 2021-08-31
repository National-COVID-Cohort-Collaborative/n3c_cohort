<div class="row"><h3>Select Medication</h3></div>
<select id="pe-med-selector" style="width: 100%"></select>
<h4 class="page-header">Medication Summary</h4>
<div class="card-flex-container stat-cards">
    <div class="card total-card">
        <div class="inner-card">
            <div class="top-row">
                <span><i class="icon fa fa-user-friends"></i></span>
                <div class="value-large" id="medCount"><span></span></div>
            </div>
            <div class="title" id="medName">
                <span></span> Total Patients
            </div>
        </div>
    </div>
    <div class="card other-cards other-card0">
        <div class="inner-card">
            <div class="top-row">
                <span class="icon fa fa-user-plus"></span>
                <div class="value-large" id="medCovidSummary">
                    <span></span>
                </div>
            </div>
            <div class="title">
                COVID positive
                <div class="subtitle" id="medCovidStat">
                    Selected <span id="medCovidSelectedStat"></span>%
                    <br>
                    Total <span id="medCovidCohortStat"></span>%
                </div>
            </div>
        </div>
    </div>
    <div class="card other-cards other-card0">
        <div class="inner-card">
            <div class="top-row">
                <span class="icon fa fa-procedures">
                </span>
                <div class="value-large" id="medHospitalizedSummary">
                    <span></span>
                </div>
            </div>
            <div class="title">
                Hospitalized
                <div class="subtitle" id="medHospitalizedStat">
                    Selected <span id="medHospitalizedSelectedStat"></span>%
                    <br>
                    Total <span id="medHospitalizedCohortStat"></span>%
                </div>
            </div>
        </div>
    </div>
    <div class="card other-cards other-card0">
        <div class="inner-card">
            <div class="top-row">
                        <span class="icon fa fa-exclamation-triangle">
                        </span>
                <div class="value-large" id="medDeathSummary">
                    <span></span>
                </div>
            </div>
            <div class="title">
                Severe outcome
                <div class="subtitle" id="medDeathStat">
                    Selected <span id="medDeathSelectedStat"></span>%
                    <br>
                    Total <span id="medDeathCohortStat"></span>%
                </div>
            </div>
        </div>
    </div>
</div>
<div id="pe-med-chart" style="margin-top: 25px"></div>
<jsp:include page="../graphs/phenotype_explorer_medication.jsp">
    <jsp:param name="med_selector" value="#pe-med-selector" />
    <jsp:param name="med_chart_container" value="#pe-med-chart" />
</jsp:include>