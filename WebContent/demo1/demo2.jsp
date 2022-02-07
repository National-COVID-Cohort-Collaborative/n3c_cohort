<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="col-xs-12 col-lg-6">
	<div id="dua_line">
		<jsp:include page="../graphs/line_data_positive_count.jsp">
			<jsp:param name="data_page" value="feeds/positive_cases_by_date.jsp" />
			<jsp:param name="dom_element" value="#dua_line" />
		</jsp:include>
	</div>
</div>
