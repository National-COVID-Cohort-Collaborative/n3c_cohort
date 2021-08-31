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
.meds .panel-heading,
.vaccine .panel-heading {
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

#machine-learning-dashboard,
#medication-dashboard{
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

<div class="row vaccine">
    <div class="col-xs-6 mx-auto">
        <div class="panel-primary">
            <div class="panel-heading">Vaccine Data</div>
            <div class="panel-body">
                <div id="vaccine-dashboard"></div>
                <jsp:include page="/tables/vaccine_dashboard.jsp"/>
            </div>
        </div>
    </div>
</div>
<div class="row meds">
    <div class="col-xs-12">
        <div class="panel-primary">
            <div class="panel-heading">Medications Table</div>
            <div class="panel-body">
                <div id="medication-dashboard"></div>
                <jsp:include page="/tables/medication_dashboard.jsp"/>
            </div>
        </div>
    </div>
</div>

