<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<div class="row comor top_panel">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">Comorbidity Distribution of COVID+ in N3C Cohort</div>
			<div class="panel-body">
				<div id="charlson-dashboard" class="table_container"></div>
				<jsp:include page="/tables/charlson_dashboard.jsp"/>
			</div>
		</div>
	</div>
</div>

<div class="row vaccine">
    <div class="col-xs-12">
        <div class="panel panel-primary">
            <div class="panel-heading">Vaccine Data</div>
            <div class="panel-body">
            	<div class="row">
            		<div class="col-xs-12 col-md-6" style="text-align:left;">
            			<p style="font-size:16px;">This table shows the number of patients who have received a COVID-19 vaccination within the N3C Data Enclave by the vaccine manufacturer. 
            			For more information on the vaccines themselves, please visit the 
            			<a href="https://www.fda.gov/emergency-preparedness-and-response/coronavirus-disease-2019-covid-19/covid-19-vaccines">FDA's COVID-19 Vaccine Information Page.</a></p>
            		</div>
            		<div class="col-xs-12 col-md-6">
            			<div id="vaccine-dashboard" class="table_container"></div>
                		<jsp:include page="/tables/vaccine_dashboard.jsp"/>
            		</div>
            	</div>
            </div>
        </div>
    </div>
</div>
<div class="row meds">
    <div class="col-xs-12">
        <div class="panel panel-primary">
            <div class="panel-heading">Medications Table</div>
            <div class="panel-body">
                <div id="medication-dashboard" class="table_container"></div>
                <jsp:include page="/tables/medication_dashboard.jsp"/>
            </div>
        </div>
    </div>
</div>

