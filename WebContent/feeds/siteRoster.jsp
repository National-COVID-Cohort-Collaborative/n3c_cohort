<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(foo))
	from (
		select
			map_label as site,
			ror_id as id,
			case when data_in_enclave = 'Yes' then 'Available' else 'Pending' end as released,
			ctr_ctsa_community as description
		from enclave_cohort.dashboard_map  where data_in_enclave !~'DTA'
		) as foo;
</sql:query>
{
    "headers": [
        {"value":"site", "label":"Site"},
        {"value":"description", "label":"Type"},
        {"value":"released", "label":"Data Status"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}

			