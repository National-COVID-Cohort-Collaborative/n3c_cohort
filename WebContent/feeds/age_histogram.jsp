<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(done))
	from (select age_bin,sum(patient_count) as patient_count from n3c_dashboard.aggregated group by 1 order by 1) as done;
</sql:query>
{
    "headers": [
        {"value":"age_bin", "label":"Age"},
        {"value":"patient_count", "label":"Patient Count"}
    ],
    "rows" : 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			