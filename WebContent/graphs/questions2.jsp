<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<style>

	@media (max-width:991px){
		.large-ques-nav{
			display:none;
		}
	}
	
	@media (min-width:991px){
		.small-ques-nav{
			display:none;
		}
	}
</style>


<div class="row stats">
	<div class="col-xs-12">
		<div class="panel-primary ">
			<div class="panel-heading">N3C Public Health Questions</div>
			<div class="large-ques-nav">
				<p>A snapshot of high value health data for policy makers, investigators, and entrepreneurs to facilitate further research questions for better health outcomes.</p>
			</div>
			<div class="small-ques-nav">
				<div class="row">
					<div class="col-xs-12 col-sm-8" style="margin:auto;">
            			<p style="font-size:18px; font-weight:400; text-align:left; margin-top:30px;">N3C Public Health Questions provide high value snapshots of health data for policy makers, investigators, and entrepreneurs to facilitate further research questions for better health outcomes.</p>
        			</div>
        		</div>
        	</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-lg-3 col-xl-2 large-ques-nav">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<div id="question-roster2"></div>
				<jsp:include page="../tables/questions_styled2.jsp" />
			</div>
		</div>
	</div>
	
	<div class="col-md-12 small-ques-nav">
		<div id="question-panel" class="panel panel-primary top_panel" style="margin-top:0px;">
			<div class="panel-body">
				<div id="question-select">
					<div id="question-button" class="btn-group">
  						<button type="button" class="btn btn-lg btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    						Choose a Question
  						</button>
						<div class="dropdown-menu">
							<div id="question-roster3"></div>
							<jsp:include page="../tables/questions_styled3.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="col-md-12 col-lg-9 col-xl-10">
		<div class="panel panel-primary top_panel">
			<div class="panel-body">
				<div id="question-tile">
					<sql:query var="roster" dataSource="jdbc/N3CCohort">
						select question,asked,description,limitations,iframe_info,iframe_content,iframe_style from n3c_questions.roster order by asked desc limit 1
					</sql:query>
					<c:forEach items="${roster.rows}" var="row" varStatus="rowCounter">
						<h2>${row.question}</h2>
						<p>${row.description}</p>
						<iframe src="https://bpvjpykbczgl7xl.us.qlikcloud.com/single/?appid=196803b0-33c2-4492-ac3b-77f6318bce47&sheet=${row.iframe_content}&qlik-web-integration-id='+integrationID&qlik-csrf-token='+token+'" style="${row.iframe_style}" ></iframe>
						<br><a class="accordion-toggle" data-toggle="collapse" data-parent="#iframe_accordion" href="#iframe_details">Details</a>
						<div id="iframe_accordian">
							<div id="iframe_details" class="panel-body panel-collapse collapse">
								<p><strong>Limitations:</strong> ${row.limitations}</p>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="resources/auth.js"></script>
