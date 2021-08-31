<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
	FROM (select
			doi,
			title,
			site,
			pub_date,
			(select jsonb_agg(bar) from (select rank,name,institution from covid_biorxiv.biorxiv_current_author where biorxiv_current_author.doi=biorxiv_current.doi order by rank) as bar) as authors
			from covid_biorxiv.biorxiv_current natural join n3c_pubs.match) as foo;
</sql:query>
{
    "headers": [
        {"value":"doi", "label":"DOI"},
        {"value":"title", "label":"Title"},
        {"value":"site", "label":"Site"},
        {"value":"pub_date", "label":"Published"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
