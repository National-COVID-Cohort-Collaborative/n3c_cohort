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
</style>
<div class="row pe">
	<div class="col-xs-12">
		<div class="panel panel-primary top_panel shadow-border">
			<p class="panel-heading">Phenotype Explorer</p>
            <div class="row">
                <div class="col-xs-3"><h4>Select Phenotype</h4></div>
                <div class="col-xs-3 pe-filter"><input type="radio" name="pe_filter" id="diagnosis" value="diagnosis"> <label for="diagnosis">Diagnosis</label></div>
                <div class="col-xs-3 pe-filter"><input type="radio" name="pe_filter" id="meds" value="meds"> <label for="meds">Meds</label></div>
                <div class="col-xs-3 pe-filter"><input type="radio" name="pe_filter" id="vitals" value="vitals"> <label for="vitals">Labs &amp; Vitals</label></div>
            </div>
            <div class="phenotype-body">
                <select class="phenotype-selector" style="width: 100%"></select>
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
            $(selector + " span").text(value);
            $(selector).show();
        }
    });
}
</script>