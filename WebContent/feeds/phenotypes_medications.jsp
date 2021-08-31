<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="meds" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
        	FROM (SELECT * FROM enclave_data.clamped_med_usage_by_severity
        	<c:choose>
            	<c:when test="${not empty param.pid}">
                WHERE phenotypeid IN (1, ${param.pid})
            	</c:when>
            	<c:otherwise>
                WHERE phenotypeid=1
            	</c:otherwise>
            </c:choose>
        	 ORDER BY variable)
         AS foo;
</sql:query>
{
   "headers": [
           {"value":"dead_w_covid", "label":"Death"},
           {"value":"mild", "label":"Mild"},
           {"value":"mild_ed", "label":"Mild ED"},
           {"value":"moderate", "label":"Moderate"},
           {"value":"severe", "label":"Severe"}
       ],
    "rows":
    <c:forEach items="${meds.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
    </c:forEach>
}