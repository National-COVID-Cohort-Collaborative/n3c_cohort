<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
    	FROM (SELECT class, name, SPLIT_PART(name, ' ', 1) AS set_name, total,
    	 all__hospitalized_and_not_, all__hospitalized_and_not__1, hospitalized,
    	 all__hospitalized_and_not__2, age, trend
         FROM enclave_cohort.meds) AS foo;
</sql:query>
{
    "headers": [
        {"value":"class", "label":"Class"},
        {"value":"name", "label":"Medication"},
        {"value":"total", "label":"N3C"},
        {"value":"all__hospitalized_and_not_", "label":"All (hospitalized and not)"},
        {"value":"all__hospitalized_and_not__1", "label":"All (hospitalized and not)"},
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

			