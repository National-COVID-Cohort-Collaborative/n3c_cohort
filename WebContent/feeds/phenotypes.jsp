<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="phenotypes" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
        	FROM (SELECT * FROM enclave_data.phenotype_final ORDER BY phenotypeid)
         AS foo;
</sql:query>
{
    "phenotypes" :
    <c:forEach items="${phenotypes.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
    </c:forEach>
}