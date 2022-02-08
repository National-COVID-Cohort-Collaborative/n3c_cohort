<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CCohort">
	select json_agg(json order by first_diagnosis_date)
	from (select
			first_diagnosis_date,
			case
				when (positive_cases = '<20') then 0
				else positive_cases::int
			end as positive_cases,
			cumsum_positivecases,
			seven_day_rolling_avg::int
		from n3c_questions.positive_cases_by_day_cumsum_censored where first_diagnosis_date::date < now()) as json;

</sql:query>

<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

