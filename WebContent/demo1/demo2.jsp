<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row stats">
	<div class="col-xs-12 col-lg-10">
	<h3>COVID+ Patients: Cumulative and 7-Day Rolling Average Counts</h3>
		<div id="dua_line">
			<jsp:include page="../graphs/line_data_positive_count.jsp">
				<jsp:param name="data_page" value="feeds/positive_cases_by_date.jsp" />
				<jsp:param name="dom_element" value="#dua_line" />
			</jsp:include>
		</div>
	</div>
</div>