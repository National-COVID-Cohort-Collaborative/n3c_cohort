<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row comor">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">Journal Articles</div>
			<div class="panel-body">
				<div id="publications-div"></div>
				<jsp:include page="../tables/papers.jsp"/>
			</div>
		</div>
	</div>
</div>
<div class="row comor">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">bioRxiv/medRxiv Preprints</div>
			<div class="panel-body">
				<div id="preprints-div"></div>
				<jsp:include page="../tables/preprints.jsp"/>
			</div>
		</div>
	</div>
</div>



