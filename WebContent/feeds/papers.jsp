<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
	FROM (SELECT 
			match.pmid,
			article_title as title,
			medline_ta as journal,
			volume,
			issue,
			(pub_date_year||'-'||pub_date_month||'-'||pub_date_day)::date as published,
			medline_pgn as pages,
			(select jsonb_agg(bar) from (select seqnum,last_name,fore_name as first_name from covid_litcovid.author where author.pmid=article.pmid order by seqnum) as bar) as authors
           FROM covid_litcovid.medline_journal_info natural join covid_litcovid.article_title natural join covid_litcovid.article natural join n3c_pubs.match) AS foo;
</sql:query>
{
    "headers": [
        {"value":"pmid", "label":"PMID"},
        {"value":"title", "label":"Title"},
        {"value":"journal", "label":"Journal"},
        {"value":"volume", "label":"Volume"},
        {"value":"issue", "label":"Issue"},
        {"value":"published", "label":"Published"},
        {"value":"pages", "label":"Pages"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
