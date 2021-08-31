<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(foo)) from (select charlson_map.value,mild,mild_ed,moderate,severe,dead_w_covid,x__all from enclave_cohort.charlson_map,enclave_cohort.charlson_frequency_for_export where abbrev=charlson_frequency_for_export.value order by 1) as foo;
</sql:query>
{
    "headers": [
        {"value":"value", "label":"Value"},
        {"value":"x__all", "label":"All"},
        {"value":"mild", "label":"Mild"},
        {"value":"mild_ed", "label":"Mild ED"},
        {"value":"moderate", "label":"Moderate"},
        {"value":"severe", "label":"Severe"},
        {"value":"dead_w_covid", "label":"Dead w/ COVID"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}

			