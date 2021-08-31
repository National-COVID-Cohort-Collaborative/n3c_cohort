<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
	FROM (SELECT domain, codeset_id, age_bracket, total_ct_n3c, concept_set_name,
           CASE WHEN concept_set_name LIKE '%N3C%' THEN split_part(concept_set_name, ' ', 2)
            ELSE concept_set_name
           END AS set_name,
           ct_covid_positive, ct_covid_positive_7d, ct_covid_positive_7d_hosp
           FROM enclave_data.priority_drug_counts) AS foo;
</sql:query>
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>