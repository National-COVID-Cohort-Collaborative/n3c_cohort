<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h3>Clinical Details</h3>

<div class="panel-body">
    <div id="medication-dashboard"></div>
    <jsp:include page="../tables/medication_dashboard.jsp"/>
    <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
    <script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
</div>