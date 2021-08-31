<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h3>Clinical Details</h3>

<div class="row ml">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">Machine Learninng</div>
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

<p>Medications Table Coming Soon!</p>




