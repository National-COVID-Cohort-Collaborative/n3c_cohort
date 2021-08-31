<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(foo))
	from (
		select institutionname as organization,ogo_group_role as type,released as available from enclave_cohort.site_coordinates order by 1
		) as foo;
</sql:query>
{
    "headers": [
        {"value":"organization", "label":"Site"},
        {"value":"type", "label":"Type"},
        {"value":"available", "label":"Data Status"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}

			