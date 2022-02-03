<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<style>

	@media (max-width:991px){
		.large-ques-nav{
			display:none;
		}
		.viz-col{
			padding:0px;
		}
	}
	
	@media (min-width:991px){
		.small-ques-nav{
			display:none;
		}
	}
</style>


<div class="row large-ques-nav">
	<div class="col-xs-12">
		<div class="panel-primary shadow-border ">
			<div class="panel-heading">N3C Public Health Browser</div>
			<div>
				<p>The data dashboards provide interactive views of <i>N3C</i> Research Program participant data. The N3C public health browser provides high value health data for policy makers, and investigators a
					snapshot of the clinical status of COVID as well as signal for further investigation within the N3C open science enclave.</p>
				<p>The data shown in the N3C public health browser comes from the N3C enclave, which is the largest collection of real-world data in the USA. The N3C Enclave comes from 69 health care
					institutions, from 49/50 states across the USA, and as of January 2022 consists of over 12 billion rows of clinical information. In addition to the RWD, the N3C enclave has a library of over 30
					external data sets from that vary from mortality, pollution index that can be linked to the clinical data. A full list of available external data sets can be found at
					<a href="https://discovery.biothings.io/dataset?guide=/guide/n3c/dataset">https://discovery.biothings.io/dataset?guide=/guide/n3c/dataset</a>.</p>
				<p>In order to protect participant privacy, the data are de-identified, limited to aggregate counts and summary demographic information, with cell counts &lt;20 not being displayed. For more
					information, please visit our <a href="https://covid.cd2h.org/faq">FAQ</a> page.</p>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12 small-ques-nav">
		<div id="question-panel" class="panel panel-primary top_panel" style="margin-top:0px;">
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-12 col-sm-8" style="margin:auto;">
            			<p style="font-size:18px; font-weight:400; text-align:left; margin-top:30px;">N3C Public Health Questions provide high value snapshots of health data for policy makers, investigators, and entrepreneurs to facilitate further research questions for better health outcomes.</p>
        			</div>
        		</div>
				<div id="question-select">
					<div id="question-button" class="btn-group">
  						<button type="button" class="btn btn-lg btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    						Choose a Question
  						</button>
						<div class="dropdown-menu">
							<div id="question-roster3"></div>
							<jsp:include page="../tables/questions_styled4.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="col-lg-3 col-xl-2 large-ques-nav">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<div id="question-roster2"></div>
			</div>
		</div>
	</div>
	
	
	<div class="col-md-12 col-lg-9 col-xl-10 viz-col">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<div id="question-tile">
				<p><i>Loading...</i></p>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="resources/auth.js"></script>
