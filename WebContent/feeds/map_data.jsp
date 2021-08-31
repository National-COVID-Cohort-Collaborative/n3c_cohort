<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
{
	"regions":
<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(foo))
	from (select id,name,sum(num_patients) as cumulative from enclave_cohort.num_patients_subregion_for_map,enclave_cohort.map_region where name=subregion group by 1,2 order by 3) as foo;
</sql:query>
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
,
	"states":
<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(foo))
	from (select map_state.id as region, map_state.name,abbrev as abbreviation, sum as count from enclave_cohort.map_state,enclave_cohort.region_frequency where map_state.id=region_frequency.id) as foo;
</sql:query>
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			