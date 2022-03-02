<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

 <sql:query var="totals" dataSource="jdbc/N3CCohort">
 	select to_char(sum(first_diagnosis)/1000000.0, '999.99')||'M' as first_diagnosis, to_char(sum(reinfected)/1000.0, '999.99')||'k' as reinfected
 	from (select 
 			case
				when (first_diagnosis_count = '<20' or first_diagnosis_count is null) then 0
				else first_diagnosis_count::int
			end as first_diagnosis,
			case
				when (original_infection_date_for_reinfected_count = '<20' or original_infection_date_for_reinfected_count is null) then 0
				else original_infection_date_for_reinfected_count::int
			end as reinfected
			from n3c_questions.covid_lds_with_reinfection_date_counts_censored) as foo
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="panel-body">
		<table>
			<tr>
				<td><i class="fas fa-users"></i></td>
				<td>&nbsp;</td>
				<td>First Diagnosis Count *</td>
			</tr>
		</table>
	</div>
	<div id="first_diagnosis_kpi" class="panel-heading">${row.first_diagnosis}</div>
</c:forEach>
