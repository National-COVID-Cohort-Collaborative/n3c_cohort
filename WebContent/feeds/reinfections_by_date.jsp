<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CCohort">
	select json_agg(json order by c_date)
	from (select
			c_date,
			case
				when (first_diagnosis_count = '<20' or first_diagnosis_count is null) then 0
				else first_diagnosis_count::int
			end as first_diagnosis,
			case
				when (original_infection_date_for_reinfected_count = '<20' or original_infection_date_for_reinfected_count is null) then 0
				else original_infection_date_for_reinfected_count::int
			end as reinfected,
			case
				when (subsequent_test_count = '<20' or subsequent_test_count is null) then 0
				else subsequent_test_count::int
			end as subsequent_test
		from n3c_questions.covid_lds_with_reinfection_date_counts_censored where c_date>'2020-00-00' and c_date::date < now()) as json;

</sql:query>

<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

