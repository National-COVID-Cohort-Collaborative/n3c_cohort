<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row stats">
	<div class="col-xs-12 ">
		<div class=" panel-primary">
			<div class="panel-heading">N3C Data Enclave Statistics</div>
			<div class="panel-body">
				<div id="overall_stats">
					<jsp:include page="../graph_support/n3c_fact_sheet.jsp" flush="true" />
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row geo">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">N3C Contributing Sites</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-12 col-md-12 col-lg-8">
						<div id="graph"></div>
					</div>
					<div class="col-xs-12 col-md-12 col-lg-4">
 						<div id="site-roster"></div>
						<jsp:include page="../tables/site_roster.jsp"/>
 					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<h3 class="first_heading">Age and Sex Distributions of N3C Cohort</h3>

<div class="row row-no-gutters age_sex">
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading panel_secondary_heading">Lab-confirmed Negative</div>
			<div class="panel-body">
				<div id="demographic-negative"></div>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading panel_secondary_heading">Lab-confirmed Positive</div>
			<div class="panel-body">
				<div id="demographic-positive"></div>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading panel_secondary_heading">No COVID Test</div>
			<div class="panel-body">
				<div id="demographic-none"></div>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading panel_secondary_heading">Suspected COVID</div>
			<div class="panel-body">
				<div id="demographic-suspected"></div>
			</div>
		</div>
	</div>
</div>

<h3 class="first_heading">Race and Ethnicity Distributions of N3C Cohort</h3>

<div class="row row-no-gutters race_ethnicity">
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading panel_secondary_heading">Lab-confirmed Negative</div>
			<div class="panel-body">
				<div id="race-negative"></div>
				<span style="font-size: 12px;">(NHPI - Native Hawaiian or Other Pacific Islander)</span>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading panel_secondary_heading">Lab-confirmed Positive</div>
			<div class="panel-body">
				<div id="race-positive"></div>
				<span style="font-size: 12px;">(NHPI - Native Hawaiian or Other Pacific Islander)</span>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading panel_secondary_heading">No COVID Test</div>
			<div class="panel-body">
				<div id="race-none"></div>
				<span style="font-size: 12px;">(NHPI - Native Hawaiian or Other Pacific Islander)</span>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading panel_secondary_heading">Suspected COVID</div>
			<div class="panel-body">
				<div id="race-suspected"></div>
				<span style="font-size: 12px;">(NHPI - Native Hawaiian or Other Pacific Islander)</span>
			</div>
		</div>
	</div>
</div>



			<jsp:include page="../graph_support/site_map.jsp" flush="true">
				<jsp:param name="ld" value="300" />
				<jsp:param name="map_type" value="${param.map_type}" />
				<jsp:param name="state_page" value="graph_support/us-states.json" />
				<jsp:param name="data_page" value="feeds/map_data.jsp" />
				<jsp:param name="site_page" value="feeds/siteLocations.jsp" />
				<jsp:param name="dom_element" value="#graph" />
			</jsp:include>

<sql:query var="facts" dataSource="jdbc/N3CCohort">
	select max(sum) from enclave_cohort.scrub_age_hist_data;
</sql:query>
<c:forEach items="${facts.rows}" var="row" varStatus="rowCounter">
	<c:set var="max_age_value" value="${row.max}" />
</c:forEach>

<jsp:include page="../graph_support/pyramid.jsp">
	<jsp:param name="data_page" value="feeds/count_by_age.jsp?status=lab_confirmed_negative" />
	<jsp:param name="dom_element" value="#demographic-negative" />
	<jsp:param name="left_header" value="Male" />
	<jsp:param name="right_header" value="Female" />
	<jsp:param name="left_label" value="# of persons" />
	<jsp:param name="middle_label" value="Age" />
	<jsp:param name="right_label" value="# of persons" />
	<jsp:param name="maxValue" value="${max_age_value}" />
</jsp:include>

<jsp:include page="../graph_support/pyramid.jsp">
	<jsp:param name="data_page" value="feeds/count_by_age.jsp?status=lab_confirmed_positive" />
	<jsp:param name="dom_element" value="#demographic-positive" />
	<jsp:param name="left_header" value="Male" />
	<jsp:param name="right_header" value="Female" />
	<jsp:param name="left_label" value="# of persons" />
	<jsp:param name="middle_label" value="Age" />
	<jsp:param name="right_label" value="# of persons" />
	<jsp:param name="maxValue" value="${max_age_value}" />
</jsp:include>

<jsp:include page="../graph_support/pyramid.jsp">
	<jsp:param name="data_page" value="feeds/count_by_age.jsp?status=no_covid_test" />
	<jsp:param name="dom_element" value="#demographic-none" />
	<jsp:param name="left_header" value="Male" />
	<jsp:param name="right_header" value="Female" />
	<jsp:param name="left_label" value="# of persons" />
	<jsp:param name="middle_label" value="Age" />
	<jsp:param name="right_label" value="# of persons" />
	<jsp:param name="maxValue" value="${max_age_value}" />
</jsp:include>

<jsp:include page="../graph_support/pyramid.jsp">
	<jsp:param name="data_page" value="feeds/count_by_age.jsp?status=suspected_COVID" />
	<jsp:param name="dom_element" value="#demographic-suspected" />
	<jsp:param name="left_header" value="Male" />
	<jsp:param name="right_header" value="Female" />
	<jsp:param name="left_label" value="# of persons" />
	<jsp:param name="middle_label" value="Age" />
	<jsp:param name="right_label" value="# of persons" />
	<jsp:param name="maxValue" value="${max_age_value}" />
</jsp:include>

<sql:query var="facts" dataSource="jdbc/N3CCohort">
	select max(sum) from enclave_cohort.scrub_race_hist_data;
</sql:query>
<c:forEach items="${facts.rows}" var="row" varStatus="rowCounter">
	<c:set var="max_race_value" value="${row.max}" />
</c:forEach>

<jsp:include page="../graph_support/grouped_bar.jsp">
	<jsp:param name="data_page"	value="feeds/count_by_race.jsp?status=lab_confirmed_negative" />
	<jsp:param name="dom_element" value="#race-negative" />
	<jsp:param name="grid_label_height" value="0" />
	<jsp:param name="maxValue" value="${max_race_value}" />
</jsp:include>

<jsp:include page="../graph_support/grouped_bar.jsp">
	<jsp:param name="data_page"	value="feeds/count_by_race.jsp?status=lab_confirmed_positive" />
	<jsp:param name="dom_element" value="#race-positive" />
	<jsp:param name="grid_label_height" value="0" />
	<jsp:param name="maxValue" value="${max_race_value}" />
</jsp:include>

<jsp:include page="../graph_support/grouped_bar.jsp">
	<jsp:param name="data_page"	value="feeds/count_by_race.jsp?status=no_covid_test" />
	<jsp:param name="dom_element" value="#race-none" />
	<jsp:param name="grid_label_height" value="0" />
	<jsp:param name="maxValue" value="${max_race_value}" />
</jsp:include>

<jsp:include page="../graph_support/grouped_bar.jsp">
	<jsp:param name="data_page"	value="feeds/count_by_race.jsp?status=suspected_COVID" />
	<jsp:param name="dom_element" value="#race-suspected" />
	<jsp:param name="grid_label_height" value="0" />
	<jsp:param name="maxValue" value="${max_race_value}" />
</jsp:include>
