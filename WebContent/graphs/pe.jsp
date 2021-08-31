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
.pe .nav-tabs>li.active>a,
.pe .nav-tabs>li.active>a:focus,
.pe .nav-tabs>li.active>a:hover {
    background-color: #337ab7;
    color: #fff;
}
.pe .nav-tabs>li>a {
    border-radius: 8px 8px 0 0;
}
.pe .panel-heading {
    text-align: left;
}
text-align: center;
</style>
<div class="row pe">
    <div class="col-xs-12">
        <div class="panel panel-primary top_panel shadow-border">
            <p class="panel-heading">Phenotype Explorer</p>
            <ul class="nav nav-tabs" style="font-size: 16px;">
                <li class="active"><a data-toggle="tab" href="#pe-comorbidity">Comorbidity Distribution</a></li>
                <li><a data-toggle="tab" href="#pe-medications">Medications</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="pe-comorbidity">
                    <jsp:include page="../tables/phenotype_explorer_comorbidity.jsp" flush="true" />
                </div>
                <div class="tab-pane fade" id="pe-medications">
                    <jsp:include page="../tables/phenotype_explorer_medication.jsp" flush="true" />
                </div>
            </div>
        </div>
    </div>
</div>