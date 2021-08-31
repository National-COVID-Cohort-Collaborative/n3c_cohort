<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style> /* set the CSS */

/* svg { */
/*   border: 1px solid #ccc; */
/* } */
.panel-primary .panel-heading{
	background-color: white;
	border: none;
    text-align: center;
}

.ml .panel-heading,
.meds .panel-heading{
    font-size: 25px;
    color: #376076;
    font-weight: normal;
}

.panel-primary {
    border-color: lightgray;
/*     margin: 10px; */
}

.first_heading{
	text-align:center;
	font-size: 25px;
	font-weight: normal; 
	color: #376076;
}

#machine-learning-dashboard{
	overflow:scroll;
}

.secondary-title{
	text-align:center; 
	font-size:18px;
	color:#376076;
	font-weight:500;
}

.table-description{
	padding-left:20px; 
	padding-right:20px; 
	font-size:16px;
}

.secondary-heading{
	text-align:center;
	font-size:16px;
	font-weight:500;
}

.row{
	margin:auto;
}

</style>


<h3>Clinical Details</h3>

<div class="row meds">
    <div class="col-xs-12">
        <div class="panel panel-primary">
            <div class="panel-heading">Medications Table</div>
            <div class="panel-body">
                <div id="medication-dashboard"></div>
                <jsp:include page="/tables/medication_dashboard.jsp"/>
                <script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
            </div>
        </div>
    </div>
</div>

<div class="row ml">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<p class="panel-heading">Predicting Clinical Severity</p>
			<p class="table-description"> To demonstrate the utility of the N3C cohort for analytics, several machine learning (ML) 
			models were developed that accurately predict a severe clinical course. All models were developed using data associated with the first calendar day of a patient's hospital encounter,
			aggregated from 34 medical centers nationwide. To avoid immortal time bias, only patients with at least 
			one hospital overnight were included, all laboratory-confirmed positive (n &asymp; 32,000). Randomly selected training (70%) and 
			testing (30%) sets were stratified by outcome proportions, and potential predictors were present for at least 15% of 
			the training set. Input variables are the most abnormal value on the first calendar day of the hospital encounter. When patients 
			did not have a laboratory test value on the first calendar day, normal values for specialized labs (e.g. ferritin, procalcitonin) 
			and the median cohort value for common labs (e.g. sodium, albumin) were imputed.</p>
			
			<div class="row">
				<div class="col-xs-12 col-md-6">
					<p class="secondary-heading">"Severe Clinical Course" was coded in the presence<br> of any of the following outcomes:</p>
					<p style="text-align:center;">Hospitalization with death</br>
					Discharge to hospice</br>
					Invasive mechanical ventilation</br>
					Extracorporeal membrane oxygenation (ECMO) </br></p>
				</div>
				<div class="col-xs-12 col-md-6">
					<p class="secondary-heading">Models Include:</p>
					<p style="text-align:center;">Random Forest (AUROC 0.86)<br>
					<a href="https://github.com/dmlc/xgboost">XGBoost</a> (AUROC 0.87)<br>
					Logistic Regression </br>
					Logistic Regrssion w/L1 Penality</br>
					Logisitc Regression w/L2 Penality</br>
					Logistic Regression w/Elastic Net Regularization</br>
					Ridge Classifier</p>
				</div>
			</div>
			
			<p class="table-description" style="margin:auto; margin-bottom:15px; text-align:center;">For more information, please see <a href="https://www.medrxiv.org/content/10.1101/2021.01.12.21249511v3">The National COVID Cohort Collaborative: 
				Clinical Characterization and Early Severity Prediction</a></p>

			<p class="secondary-title">Variable Importance in Machine Learning Models Predicting Clinical Severity</p>
			<p class="table-description"> The 64 machine learning (ML) model input variables are listed by their mean variable importance rank across ML
				model types. Each column is a ML model type. Logistic regression is shown without penalization, with L1 and
				L2 penalties, and with elastic net regularization. The table cells show a heat map with darkest (blue) representing highest variable importance and
				lightest (teal) representing lower variable importance.</p>
			
			<div class="panel-body">
				<div id="machine-learning-dashboard"></div>
				<jsp:include page="/tables/machine_learning_dashboard.jsp"/>
				 <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
				 <script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
				 <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
			</div>
		</div>
	</div>
</div>
