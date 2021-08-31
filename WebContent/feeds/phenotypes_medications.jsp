<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="meds" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
        	FROM (
                SELECT *
                FROM enclave_data.clamped_med_usage_by_severity
                WHERE variable = ?
                AND phenotypeid = 1
                ORDER BY value
            ) AS foo;
    <sql:param value="${param.name}"/>
</sql:query>

{
   "headers": [
           {"value":"mild", "label":"Mild"},
           {"value":"mild_ed", "label":"Mild ED"},
           {"value":"moderate", "label":"Moderate"},
           {"value":"severe", "label":"Severe"},
           {"value":"dead_w_covid", "label":"Dead"}
       ],
    "rows":
    <c:forEach items="${meds.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
    </c:forEach>
}