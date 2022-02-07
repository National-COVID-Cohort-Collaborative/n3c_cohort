<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CCohort">
	select json_agg(json order by first_diagnosis_date)
	from (select * from n3c_questions.positive_cases_by_day_cumsum_censored where first_diagnosis_date::date < now()) as json;

</sql:query>

<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

