<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<div class="row ml">
	<div class="col-xs-12">
		<div class="panel panel-primary top_panel">
			<p class="panel-heading">Predicting Clinical Severity</p>
			<p class="table-description"> N3C researchers used state-of-the-art Data Science and statistical methods to examine N3C data about 
			patients' tests and vitals on the first day they visited the hospital. The patterns and relationships this analysis is uncovering aim 
			to help doctors identify which patients are at highest risk of severe outcomes from  COVID-19; below are the most important factors 
			that were identified (0 = most important, 63 least important). Having this information can help doctors and caregivers adjust their 
			care decisions and lead to better patient outcomes. </p>
			<div class="panel-group" id="ml_accordion" style="margin-left:10px; margin-right:10px;">
				<div class="panel panel-default">
					<div class="panel-heading" style="background:#f9f9f9;">
						<h4 style="margin:0px; font-size:15px;">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#ml_accordion" href="#ml_collapseOne">Method Details <i class="fas fa-info-circle"></i></a>
						</h4>
					</div>
					<div id="ml_collapseOne" class="panel-collapse collapse">
						<div class="panel-body">
			 				<p class="table-description"> To demonstrate the utility of the N3C cohort for analytics, several machine learning (ML) 
								models were developed that accurately predict a severe clinical course. All models were developed using data 
								associated with the first calendar day of a patient's hospital encounter, aggregated from 34 medical centers 
								nationwide. To ensure that outcomes would be represented in the data, only patients with at least one 
								hospital overnight were included, all laboratory-confirmed positive (n &asymp; 32,000). Randomly selected 
								training (70%) and testing (30%) sets were stratified by outcome proportions, and potential predictors were present 
								for at least 15% of the training set. Input variables are the most abnormal value on the first calendar day of 
								the hospital encounter. When patients did not have a laboratory test value on the first calendar day, normal values 
								for specialized labs (e.g. ferritin, procalcitonin) and the median cohort value for common labs 
								(e.g. sodium, albumin) were imputed.</p>
							<div class="row">
								<div class="col-xs-12 col-md-6">
									<p class="secondary-heading">"Severe Clinical Course" was coded in the presence<br> of any of the following outcomes:</p>
									<p style="text-align:center;">Hospitalization with death<br>
									Discharge to hospice<br>
									Invasive mechanical ventilation<br>
									Extracorporeal membrane oxygenation (ECMO) <br></p>
								</div>
								<div class="col-xs-12 col-md-6">
									<p class="secondary-heading">Models Include:</p>
									<p style="text-align:center;">Random Forest (AUROC 0.86)<br>
									<a href="https://github.com/dmlc/xgboost">XGBoost</a> (AUROC 0.87)<br>
									Logistic Regression <br>
									Logistic Regression w/L1 Penalty<br>
									Logistic Regression w/L2 Penalty<br>
									Logistic Regression w/Elastic Net Regularization<br>
									Ridge Classifier</p>
								</div>
							</div>
							<p class="table-description" style="margin:auto; margin-bottom:15px; text-align:center;">For more information, please see <a href="https://www.medrxiv.org/content/10.1101/2021.01.12.21249511v3">The National COVID Cohort Collaborative: 
				Clinical Characterization and Early Severity Prediction</a></p>
						</div>
			    	</div>
				</div>
			</div>
			
			<p style="padding-left:20px; padding-right:20px;"> <strong>Variable Importance Table: </strong> 64 metrics and their importance rank in predicting if a patient would have a 
			severe response to COVID-19 (0 = most important, 63 = least important) are shown below. Each column represents a different model 
			built to predict severity. The color of the cell corresponds to each metric's rank, with darkest (blue) representing the highest 
			importance and lightest (teal) representing lower importance. </p>
			
			<div class="panel-body">
				<div class="table_container" id="machine-learning-dashboard"></div>
				<jsp:include page="/tables/machine_learning_dashboard.jsp"/>
			</div>
		</div>
	</div>
</div>
