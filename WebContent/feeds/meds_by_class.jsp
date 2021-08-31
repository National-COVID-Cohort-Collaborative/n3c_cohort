<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(meds)) from enclave_cohort.meds;
</sql:query>
{
    "headers": [
        {"value":"class", "label":"Class"},
        {"value":"name", "label":"Medication"},
        {"value":"total", "label":"Total"},
        {"value":"all__hospitalized_and_not_", "label":"COVID+"},
        {"value":"all__hospitalized_and_not__1", "label":"Not Hospitalized"},
        {"value":"hospitalized", "label":"Hospitalized"},
        {"value":"all__hospitalized_and_not__2", "label":"All (hospitalized and not)"},
        {"value":"trend", "label":"Trend"},
        {"value":"age", "label":"Age"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}

			