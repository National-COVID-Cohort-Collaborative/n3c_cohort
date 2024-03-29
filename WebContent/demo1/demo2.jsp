<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row stats">
	<div class="col-xs-12 col-lg-10">
	<h3>COVID+ Patients: Cumulative and 7-Day Rolling Average Counts</h3>
		<div id="pos_cumulative">
			<jsp:include page="../graph_support/time_line_2_column.jsp">
				<jsp:param name="data_page" value="feeds/positive_cases_by_date.jsp" />
				<jsp:param name="dom_element" value="#pos_cumulative" />
				<jsp:param name="date_column" value="first_diagnosis_date" />
				<jsp:param name="column1" value="cumsum_positivecases" />
				<jsp:param name="column1_label" value="Cumulative COVID+ Patient Count" />
				<jsp:param name="column1_tip" value="Cumulative" />
				<jsp:param name="column1_tip_offset" value="90" />
				<jsp:param name="column2" value="seven_day_rolling_avg" />
				<jsp:param name="column2_label" value="Rolling 7-Day Average Patient Count" />
				<jsp:param name="column2_tip" value="7-Day Ave" />
				<jsp:param name="column2_tip_offset" value="80" />
			</jsp:include>
		</div>
	<h3>COVID+ Patients: Daily Patient Counts and 7-Day Rolling Averages</h3>
		<div id="pos_rolling">
			<jsp:include page="../graph_support/time_line_2_column.jsp">
				<jsp:param name="data_page" value="feeds/positive_cases_by_date.jsp" />
				<jsp:param name="dom_element" value="#pos_rolling" />
				<jsp:param name="date_column" value="first_diagnosis_date" />
				<jsp:param name="column1" value="positive_cases" />
				<jsp:param name="column1_label" value="COVID+ Patient Count" />
				<jsp:param name="column1_tip" value="COVID+" />
				<jsp:param name="column1_tip_offset" value="70" />
				<jsp:param name="column2" value="seven_day_rolling_avg" />
				<jsp:param name="column2_label" value="Rolling 7-Day Average Patient Count" />
				<jsp:param name="column2_tip" value="7-Day Ave" />
				<jsp:param name="column2_tip_offset" value="80" />
				<jsp:param name="useColumn1Scaling" value="true" />
				<jsp:param name="column1_opacity" value="0.25" />
			</jsp:include>
		</div>
	</div>
</div>