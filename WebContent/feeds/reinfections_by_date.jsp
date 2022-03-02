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
			end as subsequent_test,
			first_diagnosis_count as first_diagnosis_display,
			original_infection_date_for_reinfected_count as reinfected_display,
			subsequent_test_count as subsequent_test_display
		from n3c_questions.covid_lds_with_reinfection_date_counts_censored where c_date>'2020-00-00' and c_date::date < now()
		<c:if test="${not empty param.headers}"> or c_date is null</c:if>
		) as json;

</sql:query>

<c:if test="${not empty param.headers}">
{
    "headers": [
        {"value":"c_date", "label":"Date"},
        {"value":"first_diagnosis", "label":"First Diagnosis Case Count"},
        {"value":"reinfected", "label":"Reinfection Case Count"},
        {"value":"subsequent_test", "label":"Subsequent Positive Test Case Count"},
        {"value":"first_diagnosis_display", "label":"First Diagnosis Case Count"},
        {"value":"reinfected_display", "label":"Reinfection Case Count"},
        {"value":"subsequent_test_display", "label":"Subsequent Positive Test Case Count"}
    ],
    "rows" : 
</c:if>
<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>
<c:if test="${not empty param.headers}">
}
</c:if>
