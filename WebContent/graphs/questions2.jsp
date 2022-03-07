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
							<jsp:include page="../tables/questions_styled4.jsp?tertiary_tab=${param.tertiary_tab}"/>
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

