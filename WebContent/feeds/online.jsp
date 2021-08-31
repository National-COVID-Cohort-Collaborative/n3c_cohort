<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
	FROM (select * from n3c_pubs.online_cache) AS foo;
</sql:query>
{
    "headers": [
        {"value":"doi", "label":"DOI"},
        {"value":"title", "label":"Title"},
        {"value":"journal", "label":"Journal"},
        {"value":"published", "label":"Published"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
