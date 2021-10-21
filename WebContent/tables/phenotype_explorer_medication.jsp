<div class="well well-sm">The starting population of patients as produced by executing the code from the Cohort paper against the latest release.</div>
<div class="row"><h3>Select Medication</h3></div>
<select id="pe-med-selector" style="width: 100%"></select>
<h4 class="page-header">Medication Summary</h4>
<div class="card-flex-container stat-cards hidden">
    <div class="card total-card">
        <div class="inner-card">
            <div class="top-row">
                <span><i class="icon fa fa-user-friends"></i></span>
                <div class="value-large" id="medCount"><span></span></div>
            </div>
            <div class="title" id="medName">
                <span></span> Patients
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
<div>
    <table class="table hidden" id="medSumTable">
        <thead class="thead-light">
          <tr>
            <th scope="col" rowspan="2" class="align-middle">Comparison</th>
            <th scope="col" rowspan="2" class="align-middle">Total Cohort (C+ & C-)</th>
            <th scope="col" colspan="6" class="text-center">COVID (C+)</th>
            <th scope="col" rowspan="2" class="align-middle">COVID (C-) Patients</th>
          </tr>
          <tr>
              <th scope="col" class="bg-light">Outpatients</th>
              <th scope="col" class="bg-light">ED Visit</th>
              <th scope="col" class="bg-light">Hospitalized</th>
              <th scope="col" class="bg-light">ICU</th>
              <th scope="col" class="bg-light">Deceased</th>
              <th scope="col" class="bg-light">Total</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row" id="tabMedName"><span id="sMedName"></span> CT/ (%)</th>
            <th scope="row"><span id="sMedTotalCohort"></span> (100%)</th>
            <th scope="row" class="bg-light">
                <div><span id="sMedOutpatients"></span></div>
                <div><span id="sMedOutpatientsToCPos"></span></div>
            </th>
            <th scope="row" class="bg-light">
                <div><span id="sMedEdVisit"></span></div>
                <div><span id="sMedEdVisitToCPos"></span></div>
            </th>
            <th scope="row" class="bg-light">
                <div><span id="sMedHostpitalized"></span></div>
                <div><span id="sMedHostpitalizedToCPos"></span></div></th>
            <th scope="row" class="bg-light">
                <div><span id="sMedICU"></span></div>
                <div><span id="sMedICUToCPos"></span></div>
            </th>
            <th scope="row" class="bg-light">
                <div><span id="sMedDeceased"></span></div>
                <div><span id="sMedDeceasedToCPos"></span></div>
            </th>
            <th scope="row" class="bg-light">
                            <span id="sMedCovidPos"></span>
            </th>
            <th scope="row"><span id="sMedCovidNeg"></span></th>
          </tr>
          <tr>
            <th scope="row">All Patients CT/ (%)</th>
            <th scope="row"><span id="sAllTotalCohort"></span></th>
            <th scope="row" class="bg-light"><span id="sAllOutpatients"></span></th>
            <th scope="row" class="bg-light"><span id="sAllEdVisit"></span></th>
            <th scope="row" class="bg-light"><span id="sAllHostpitalized"></span></th>
            <th scope="row" class="bg-light"><span id="sAllICU"></span></th>
            <th scope="row" class="bg-light"><span id="sAllDeceased"></span></th>
            <th scope="row" class="bg-light"><span id="sAllCovidPos"></span></th>
            <th scope="row"><span id="sAllCovidNeg"></span></th> 
          </tr>
        </tbody>
      </table>
</div>
<div id="pe-med-chart" style="margin-top: 25px"></div>
<jsp:include page="../graphs/phenotype_explorer_medication.jsp">
    <jsp:param name="med_selector" value="#pe-med-selector" />
    <jsp:param name="med_chart_container" value="#pe-med-chart" />
</jsp:include>