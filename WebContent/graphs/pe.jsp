<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
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
                <div class="col-xs-3 pe-filter"><input type="radio" name="pe_filter" id="diagnosis" value="diagnosis"> <label for="diagnosis">Diagnosis</label></div>
            </div>
            <div class="phenotype-body">
                <select class="phenotype-selector" style="width: 100%"></select>
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
                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#pe_accordion" href="#pe_collapseOne">Show / Hide Details <i class="fas fa-info-circle"></i></a>
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
                                        <blockquote class="blockquote"><span></span></blockquote>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="phenotype-explorer-comorbidity">
                <h4 class="page-header">Comorbidity distribution within cohort</h4>
                <jsp:include page="/tables/phenotype_explorer_comorbidity.jsp" flush="true" />
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

    $('.phenotype-selector').select2({data: peFilter});

    // show the default phenotype
    phenotypeDetails(1);

    // Default to Diagnosis
    $(".pe-filter input:radio").first().attr('checked', 'checked');
});

// onSelect -> search thru main collection and retrieve data
$('.phenotype-selector').on('select2:select', (e) => {
    var data = e.params.data;
    phenotypeDetails(data.id);
});

// Phenotype details
function phenotypeDetails(phenotypeId) {
    phenotype = phenotypes['pe_' + phenotypeId];

    if (jQuery.isEmptyObject(phenotype))
        return;

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

    loadAdditionalPhenotypeDetailsForPhenotype(phenotypeId)
}
</script>