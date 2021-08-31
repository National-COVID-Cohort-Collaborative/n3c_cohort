<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="drugs" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(done))
	from (
			select age as group,coalesce(male,0) as right,coalesce(female,0) as left from (select age from enclave_cohort.age) as foo
			natural left outer join
			(select age_at_visit_start_in_years_int as age, sum as male from enclave_cohort.scrub_age_hist_data where gender_concept_name='MALE' and covid_status_name = ? ) as bar
			natural left outer join
			(select age_at_visit_start_in_years_int as age, sum as female from enclave_cohort.scrub_age_hist_data where gender_concept_name='FEMALE' and covid_status_name = ? ) as barn
		order by 1
	) as done;
	<sql:param>${param.status}</sql:param>
	<sql:param>${param.status}</sql:param>
</sql:query>
<c:forEach items="${drugs.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
			