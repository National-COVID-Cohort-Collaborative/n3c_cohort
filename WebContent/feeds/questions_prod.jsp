<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo order by seqnum))
	FROM (select question,asked,description,limitations,iframe_info,iframe_content,iframe_style,seqnum from n3c_questions.roster where visible) as foo;
</sql:query>
{
    "headers": [
        {"value":"question", "label":"Question"},
        {"value":"asked", "label":"Ask Date"},
        {"value":"description", "label":"Description"},
        {"value":"limitations", "label":"Limitations"},
        {"value":"iframe_info", "label":"IFrame info"},
        {"value":"iframe_content", "label":"IFrame content"},
        {"value":"iframe_style", "label":"IFrame style"},
        {"value":"seqnum", "label":"seqnum"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
