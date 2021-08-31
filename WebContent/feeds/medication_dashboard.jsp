<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="medications" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
	FROM(SELECT class,name,total,covid_positive,not_hospitalized,hospitalized,med_8
	     FROM enclave_cohort.med_test ORDER BY name) as foo;
</sql:query>
{
    "headers": [
        {"value":"class", "label":"Class"},
        {"value":"name", "label":"Name"},
        {"value":"total", "label":"Total"},
        {"value":"covid_positive", "label":"COVID+"},
        {"value":"not_hospitalized", "label":"Not Hospitalized"},
        {"value":"hospitalized", "label":"Hospitalized"},
        {"value":"med_8", "label":"All (hospitalized and not)"},
        {"value":"", "label":"Trend"},
        {"value":"", "label":"Age"}
    ],
    "rows" :
<c:forEach items="${medications.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}


