<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="meds" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo order by name))
        	FROM (
        	    SELECT mild, value, severe, mild_ed, moderate, variable AS name, dead_w_covid,
        	     phenotypename AS phenotype, md5(variable) AS variable, md5(phenotypename) AS hashid
                 FROM enclave_data.clamped_med_usage_by_severity meds
                 LEFT JOIN enclave_data.phenotype_final pe ON (meds.phenotypeid=pe.phenotypeid)
        	<c:choose>
            	<c:when test="${not empty param.pid}">
                WHERE meds.phenotypeid IN (1, ${param.pid})
            	</c:when>
            	<c:otherwise>
                WHERE meds.phenotypeid=1
            	</c:otherwise>
            </c:choose>
            ) AS foo;
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