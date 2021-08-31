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
}

.table-description{
	padding-left:20px; 
	padding-right:20px; 
	font-size:16px;
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
			<div class="panel-heading">Machine Learning</div>
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
