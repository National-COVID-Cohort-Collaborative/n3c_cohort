<script src="resources/select2.min.js"></script>
<style type="text/css" media="all">
@import "resources/select2.min.css";
</style>
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
                <div class="row">
                    <select class="phenotype-selector" style="width: 100%">
                        <option value="1" selected="selected">All Patients</option>
                    </select>
                </div>
                <div class="phenotype-description">
                    <div class="title">Clinical Description</div>
                    <span id="clinicaldescription">This is the clinical Description</span>
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
                                    <div><strong>Cohort name</strong></div>
                                    <span id="cohortname">[PL 316139001] Heart failure referent concept incident cohort: First occurrence of referent concept + descendants with >=365d prior observation</span>

                                    <div class="title">Cohort JSON</div>
                                    <blockquote class="blockquote">
                                    {"cdmVersionRange": ">=5.0.0", "PrimaryCriteria": {"CriteriaList": [{"ConditionOccurrence": {"CodesetId": 0, "First": true, "ConditionTypeExclude": false}}], "ObservationWindow": {"PriorDays": 365, "PostDays": 0}, "PrimaryCriteriaLimit": {"Type": "First"}}, "ConceptSets": [{"id": 0, "name": "Heart failure", "expression": {"items": [{"concept": {"CONCEPT_ID": 316139, "CONCEPT_NAME": "Heart failure", "STANDARD_CONCEPT": "S", "STANDARD_CONCEPT_CAPTION": "Standard", "INVALID_REASON": "V", "INVALID_REASON_CAPTION": "Valid", "CONCEPT_CODE": "84114007", "DOMAIN_ID": "Condition", "VOCABULARY_ID": "SNOMED", "CONCEPT_CLASS_ID": "Clinical Finding"}, "isExcluded": false, "includeDescendants": true, "includeMapped": false}]}}], "QualifiedLimit": {"Type": "First"}, "ExpressionLimit": {"Type": "First"}, "InclusionRules": [], "CensoringCriteria": [], "CollapseSettings": {"CollapseType": "ERA", "EraPad": 0}, "CensorWindow": {}}
                                    </blockquote>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
	</div>
</div>
<script>
$(function() {
    $('.phenotype-selector').select2({
        ajax: {
            url: 'feeds/phenotypes.jsp',
            dataType: 'json',
            minimumInputLength: 2,
            processResults: (data) => {
                return {
                    results: data.rows
                };
            },
            success: (event, response) => {
                console.log(response);
                Select2.constructor.__super__.trigger.call(Select2, 'select', event.params.args);
            }
        }
    });

    $('.phenotype-selector').on('select2:select', (e) => {
        var data = e.params.data;
        console.log(data);
    });
});
</script>