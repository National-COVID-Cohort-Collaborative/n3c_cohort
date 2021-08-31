<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="resources/phenotype.js" type="text/javascript"></script>
<style>
div.phenotype-details {
    margin-top: 20px;
}
div.pe-filter {
    margin-top: 10px;
}
div.phenotype-body {
    padding-left: 15px;
    padding-right: 20px;
}
div.phenotype-description {
    margin-top: 20px;
}
.select2 {
    font-size: 16px;
}
.title {
    font-weight: 600;
    margin-bottom: 10px;
    margin-top: 10px;
}
.card {border: 0}
.card-flex-container {
    display: flex;
    flex-flow: row wrap;
    align-items: stretch;
    justify-content: center;
}
.stat-cards .total-card {
    align-self: flex-start;
}
.stat-cards .card {
    display: flex;
    flex-direction: row;
    align-items: center;
    flex-grow: 1;
}
.stat-cards .other-card0 {
    border-left: 1px solid #ced9e0;
    padding-left: 15px;
}
.stat-cards .inner-card {
    display: flex;
    align-items: left;
    flex-grow: 1;
    flex-direction: column;
}
.stat-cards .top-row {
    display: flex;
    align-items: center;
    flex-grow: 1;
    flex-direction: row;
}
.stat-cards .value-large {
    color: #4B6AB2;
    font-size: 32px;
    line-height: 32px;
    font-weight: 600;
    padding-left: 5px;
}
.stat-cards .title {
    color: #8a9ba8;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    margin-left: 30px;
}
.stat-cards .title .subtitle{
    font-weight: 500;
    color: #10161a;
    text-transform: none
}
.stat-cards .icon {
    color: #91ACE5;
    font-size: 20px;
}
</style>
<div class="row pe">
	<div class="col-xs-12">
		<div class="panel panel-primary top_panel shadow-border">
			<p class="panel-heading">Phenotype Explorer</p>
            <div class="row">
                <div class="col-xs-3"><h4>Select Phenotype</h4></div>
            </div>
            <div class="phenotype-body">
                <select id="phenotype-selector" style="width: 100%"></select>
                <h4 class="page-header">Phenotype Summary</h4>
                <div class="card-flex-container stat-cards">
                    <div class="card total-card">
                        <div class="inner-card">
                            <div class="top-row">
                                <span><i class="icon fa fa-user-friends"></i></span>
                                <div class="value-large" id="count"><span></span></div>
                            </div>
                            <div class="title" id="phenotypename">
                                <span></span> cohort size
                            </div>
                        </div>
                    </div>
                    <div class="card other-cards other-card0">
                        <div class="inner-card">
                            <div class="top-row">
                                <span class="icon fa fa-user-plus"></span>
                                    <div class="value-large" id="covidSummary">
                                        <span></span>
                                    </div>
                            </div>
                            <div class="title">
                                COVID positive
                                <div class="subtitle" id="covidStat">
                                    <span id="covidSubStat"></span>% of phenotype vs
                                     <br>
                                    <span id="covidAllStat"></span>% all patients
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card other-cards other-card0">
                        <div class="inner-card">
                            <div class="top-row">
                                <span class="icon fa fa-procedures">
                                </span>
                                <div class="value-large" id="hospitalizedSummary">
                                    <span></span>
                                </div>
                            </div>
                            <div class="title">
                                Hospitalized
                                <div class="subtitle" id="hospitalizedStat">
                                    <span id="hospitalizedSubStat"></span>% of phenotype vs
                                     <br>
                                    <span id="hospitalizedAllStat"></span>% all patients
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card other-cards other-card0">
                        <div class="inner-card">
                            <div class="top-row">
                                <span class="icon fa fa-exclamation-triangle">
                                </span>
                                <div class="value-large" id="deathSummary">
                                    <span></span>
                                </div>
                            </div>
                            <div class="title">
                                Severe outcome
                                <div class="subtitle" id="deathStat">
                                    <span id="deathSubStat"></span>% of phenotype vs
                                     <br>
                                    <span id="deathAllStat"></span>% all patients
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="phenotype-description">
                    <div id="clinicaldescription">
                        <div class="title">Clinical Description</div>
                        <span></span>
                    </div>
                </div>
                <div class="phenotype-details">
                    <div class="panel-group" id="pe_accordion">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h5 style="margin:0px; font-size:15px;">
                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#pe_accordion"
                                     href="#pe_collapseOne">Show / Hide Details <i class="fas fa-info-circle"></i>
                                     </a>
                                </h5>
                            </div>
                            <div id="pe_collapseOne" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <div id="cohortname">
                                        <div><strong>Cohort name</strong><br/></div>
                                        <span></span>
                                    </div>

                                    <div id="logicdescription">
                                        <div class="title">Logic Description</div>
                                        <span></span>
                                    </div>

                                    <div id="cohortjson">
                                        <div class="title">Cohort JSON</div>
                                        <pre><span></span></pre>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="pe-stats">
                <ul class="nav nav-tabs" style="font-size: 16px;">
                    <li class="active"><a data-toggle="tab" href="#pe-comorbidity">Comorbidity Distribution</a></li>
                    <li><a data-toggle="tab" href="#pe-medications">Medications</a></li>
               </ul>
               <div class="tab-content">
                    <div class="tab-pane fade in active" id="pe-comorbidity">
                        <h4 class="page-header"><strong>Comorbidity distribution within cohort</strong></h4>
                        <jsp:include page="/tables/phenotype_explorer_comorbidity.jsp" flush="true" />
                    </div>
                    <div class="tab-pane fade" id="pe-medications">
                        <h4 class="page-header"><strong>Medications</strong></h4>
                        <select id="pe-med-selector" style="width: 100%"></select>
                        <div id="pe-med-chart"></div>
                        <jsp:include page="/graphs/phenotype_explorer_medication.jsp">
                            <jsp:param name="pe_selector" value="#phenotype-selector" />
                            <jsp:param name="med_selector" value="#pe-med-selector" />
                            <jsp:param name="med_chart_container" value="#pe-med-chart" />
                        </jsp:include>
                    </div>
                </div>
            </div>
	</div>
</div>
<script>
var phenotypes = {};
var peFilter = [];

$.getJSON("feeds/phenotypes.jsp", (data) => {
    let json = $.parseJSON(JSON.stringify(data));

    json['phenotypes'].forEach((row, i) => {
        let peIndex = 'pe_' + row.phenotypeid;
        phenotypes[peIndex] = row;

        // build phenotype dropdown
        peFilter.push({id: row.phenotypeid, text: row.phenotypename});
    });

    $('#phenotype-selector').select2({data: peFilter});

    loadDefaultDetailsForPhenotype(1);
});

// onSelect -> search thru main collection and retrieve data
$('#phenotype-selector').on('select2:select', (e) => {
    var data = e.params.data;

    loadDefaultDetailsForPhenotype(data.id);
});

// Phenotype details
function phenotypeDetails(phenotypeId) {
    phenotype = phenotypes['pe_' + phenotypeId];

    if (jQuery.isEmptyObject(phenotype))
        return;

    let allCohortCount = phenotypes['pe_1'].count;
    let phenotypeCount = phenotypes['pe_' + phenotypeId].count;

    $.each(phenotype, (field, value) => {
        selector = '#' + field;

        if (!value) {
            $(selector).hide();
        } else {
            value = field === "count" ? value.toLocaleString() : value;

            $(selector + " span").text(value);
            $(selector).show();
        }
    });

    let statFeedUrl = "feeds/phenotype_explorer_stat.jsp";
    let statCategories = ["covid","hospitalized","death"]

    statCategories.map(statCategory => {
        let allCount = 0;
        let subCount = 0;

        $.getJSON(statFeedUrl + "?category=" + statCategory + "&pid=" + phenotypeId, (data) => {
            let json = $.parseJSON(JSON.stringify(data))

            allCount = json[statCategory].all;
            subCount = json[statCategory].sub || allCount;

            let allStat = ((allCount/allCohortCount) * 100).toFixed(1);
            let subStat = ((subCount/phenotypeCount) * 100).toFixed(1);

            let selector = "#" + statCategory;
            $(selector + "Summary span").text(subCount.toLocaleString());
            $(selector + "SubStat").text(subStat)
            $(selector + "AllStat").text(allStat)
        });
    });
}

function loadDefaultDetailsForPhenotype(phenotypeId) {
    // show the default phenotype in the dropdown
    phenotypeDetails(phenotypeId);

    // load comorbidity table
    comorbidityForPhenotype(phenotypeId);

    // load medication chart
    medicationsForPhenotype(phenotypeId);
}
</script>