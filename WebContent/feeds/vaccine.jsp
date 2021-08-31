<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="vaccine" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(vaccine)) from enclave_cohort.vaccine;
</sql:query>
{
    "headers": [
        {"value":"common_name", "label":"Vaccine"},
        {"value":"count", "label":"Patients"},
        {"value":"detail_name", "label":"Description"}
    ],
    "rows" :
    <c:forEach items="${vaccine.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
    </c:forEach>
}

