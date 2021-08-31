<div class="row"><h3>Select Phenotype</h3></div>
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
<div id="peComorbidityTableContainer">
    <h4 class="page-header"><strong>Comorbidity distribution within cohort</strong></h4>
</div>
<script type="text/javascript">
var phenotypes = {},
    peFilter = [],
    allCohortCount = 0;

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
    const phenotype = phenotypes['pe_' + phenotypeId];

    if (! Object.keys(phenotype).length)
        return;

    allCohortCount = phenotypes['pe_1'].count;
    let phenotypeCount = phenotypes['pe_' + phenotypeId].count;

    $.each(phenotype, (field, value) => {
        let selector = '#' + field;

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
            subCount = phenotypeId == 1 ? allCount : json[statCategory].sub;

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
}

function comorbidityForPhenotype(phenotypeId) {
    $.getJSON("feeds/phenotypes_comorbidity.jsp?pid=" + phenotypeId, (data) => {
        const json = $.parseJSON(JSON.stringify(data))
        const allowedKeys = json['headers'].map(item => item.value)

        const comorbidityGrouped = dataGrouped(json['rows']);
        const comorbidityTrue = json['rows'].filter(row => row.value);
        const comorbidityCalculated = dataPercentage(comorbidityGrouped, comorbidityTrue, allowedKeys);

        // build the data for the comorbidity table
        const comorbidityTableData = buildComorbidityTable(comorbidityCalculated, allowedKeys);

        // Build the Comorbidity DataTable
        let peComorbidityTable;
        if ($.fn.dataTable.isDataTable('#pe_comorbidity_table')) {
            peComorbidityTable = $('#pe_comorbidity_table').DataTable();
            peComorbidityTable.clear().draw();
            peComorbidityTable.rows.add(comorbidityTableData).draw();
        } else {
            var table = document.createElement("table");
                table.className = 'table table-hover';
                table.style.width = '100%';
                table.id = "pe_comorbidity_table";

            var divContainer = document.getElementById("peComorbidityTableContainer");
            divContainer.appendChild(table);

            peComorbidityTable = $('#pe_comorbidity_table').DataTable( {
                data: comorbidityTableData,
                paging: false,
                retrieve: true,
                order: [[0, 'asc']],
                columnDefs: [
                    {className: "dt-center", targets: [1,2,3,4,5,6] }
                ],
                columns: [
                    { data: "variable" },
                    { data: "unaffected", title: "Unaffected" },
                    { data: "mild", title: "Mild" },
                    { data: "mild_ed", title: "Mild ED" },
                    { data: "moderate", title: "Moderate" },
                    { data: "severe", title: "Severe" },
                    { data: "dead_w_covid", title: "Death" }
                ]
            });
        }
    });
}

/**
 * Build the Comorbidity Table Object
 */
function buildComorbidityTable(comorbidityData, allowedKeys) {
    const comorbidityDict = {
        "PVD":          "Peripheral Vascular Disease",
        "CHF":          "Congestive Heart Failure",
        "Renal":        "Renal Disease",
        "Pulmonary":    "Chronic Pulmonary Disease",
        "Dementia":     "Dementia",
        "Stroke":       "Stroke",
        "Rheumatic":    "Rheumatologic Disease",
        "HIV":          "HIV",
        "DMcx":         "Diabetes Mellitus w/ complications",
        "DM":           "Diabetes Mellitus",
        "LiverMild":    "Liver Disease, mild",
        "LiverSevere":  "Liver Disease, severe",
        "Cancer":       "Cancer",
        "Mets":         "Cancer, Metastatic",
        "Any_Cancer":   "Cancer",
        "Any_Liver":    "Liver Disease",
        "Any_DM":       "Diabetes Mellitus",
        "MI":           "Heart Attack",
        "Paralysis":    "Partial Paralysis/Weakness",
        "PUD":          "Peptic Ulcer Disease"
    };

    const comorbidityTableData = comorbidityData.map(obj => {
        const comorbidityName = comorbidityDict[obj.variable];
        const comorbidityFiltered = filterObject(obj, allowedKeys);

        let comorbidityRow = {};

        for (const [key, value] of Object.entries(comorbidityFiltered)) {
            comorbidityRow[key] = value.toFixed(3) + '%';
        }
        comorbidityRow['variable'] = comorbidityName;

        return comorbidityRow;
    })

    return comorbidityTableData
}
</script>