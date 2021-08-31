<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
    	FROM (SELECT phenotypeid AS id, phenotypename AS text FROM enclave_data.phenotype_final WHERE phenotypename ILIKE ?
 ) AS foo;
 <sql:param>${param.q}%</sql:param>
</sql:query>
{
    "rows" :
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}