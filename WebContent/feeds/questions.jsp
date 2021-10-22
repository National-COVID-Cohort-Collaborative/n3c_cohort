<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
	FROM (select * from n3c_questions.roster) as foo;
</sql:query>
{
    "headers": [
        {"value":"question", "label":"Question"},
        {"value":"asked", "label":"Ask Date"},
        {"value":"description", "label":"Description"},
        {"value":"limitations", "label":"Limitations"},
        {"value":"iframe_info", "label":"IFrame info"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
