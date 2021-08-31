<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="phenotypes" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
        	FROM (SELECT * FROM enclave_data.clamped_diagnoses_by_severity
        	 <c:if test="${not empty param.pid}"> WHERE phenotypeid=${param.pid}</c:if>
        	 ORDER BY variable)
         AS foo;
</sql:query>
{
   "headers": [
           {"value":"dead_w_covid", "label":"Death"},
           {"value":"mild", "label":"Mild"},
           {"value":"mild_ed", "label":"Mild ED"},
           {"value":"moderate", "label":"Moderate"},
           {"value":"severe", "label":"Severe"},
           {"value":"unaffected", "label":"Unaffected"}
       ],
    "rows" :
    <c:forEach items="${phenotypes.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
    </c:forEach>
}