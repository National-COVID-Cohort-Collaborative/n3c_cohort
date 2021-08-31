<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="drugs" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select
			value as race,
			abbrev,
			seq,
			(select jsonb_agg(sub)
			 from (select bar.ethnicity,sum
			 		from enclave_cohort.race_hist_data as bar, enclave_cohort.ethnicity_map
			 		where ethnicity_map.ethnicity=bar.ethnicity
			 		  and race_map.value=bar.race
			 		  and covid_status_name = ?
			 		  order by seq ) as sub
			 ) as values
		from
			enclave_cohort.race_map
		order by seq
	) as done;
	<sql:param>${param.status}</sql:param>
</sql:query>
<c:forEach items="${drugs.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
			