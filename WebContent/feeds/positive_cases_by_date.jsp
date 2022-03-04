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
			seven_day_rolling_avg::int,
			positive_cases as positive_cases_display,
			cumsum_positivecases as cumsum_positivecases_display,
			to_char(seven_day_rolling_avg::float, '999999.99') as seven_day_rolling_avg_display
		from n3c_questions.positive_cases_by_day_cumsum_censored where first_diagnosis_date::date < now()) as json;

</sql:query>

<c:if test="${not empty param.headers}">
{
    "headers": [
        {"value":"first_diagnosis_date", "label":"First Diagnosis Date"},
        {"value":"positive_cases", "label":"Positive Case Count"},
        {"value":"cumsum_positivecases", "label":"Cumulative Positive Case Count"},
        {"value":"seven_day_rolling_avg", "label":"7-Day Rolling Average Case Count"},
        {"value":"positive_cases_display", "label":"Positive Case Count"},
        {"value":"cumsum_positivecases_display", "label":"Cumulative Positive Case Count"},
        {"value":"seven_day_rolling_avg_display", "label":"7-Day Rolling Average Case Count"}
    ],
    "rows" : 
</c:if>
<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>
<c:if test="${not empty param.headers}">
}
</c:if>
