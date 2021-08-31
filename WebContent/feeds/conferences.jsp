<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
	FROM (select title,correspondingauthor,pub_date,(pub_date > now()) as future from n3c_pubs.conference_cache) as foo;
</sql:query>
{
    "headers": [
        {"value":"title", "label":"Title"},
        {"value":"correspondingauthor", "label":"Corresponding Author"},
        {"value":"pub_date", "label":"Date"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
