<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(foo))
	from (
		select
			site,
			id,
			url,
			type,
			status
		from n3c_maps.sites
		) as foo;
</sql:query>
{
    "headers": [
        {"value":"site", "label":"Site"},
        {"value":"type", "label":"Type"},
        {"value":"status", "label":"Data Status"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}

			