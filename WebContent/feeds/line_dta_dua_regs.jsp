<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select json_agg(json)
	from (select * from
		(SELECT 
			date_trunc('week', week::date) AS date,
   			sum(COUNT(duaexecuted)) OVER (ORDER BY date_trunc('week', week::date)) as duas
		FROM
			(select week, duaexecuted from (
				select generate_series(date_trunc('week', min(created::date)), date_trunc('week', now() ), '1 week'::interval) as week 
				from n3c_admin.registration) as foo
				LEFT JOIN n3c_admin.dua_master on (week = date_trunc('week', n3c_admin.dua_master.duaexecuted::date))) as test
				GROUP BY date) as foo
		natural full outer join
			(SELECT 
				date_trunc('week', week::date) AS date,
       			sum(COUNT(email)) OVER (ORDER BY date_trunc('week', week::date)) as registrations
			FROM
				(select week, email from (
					select generate_series(date_trunc('week', min(created::date)), date_trunc('week', now() ), '1 week'::interval) as week 
					from n3c_admin.registration) as foo
					LEFT JOIN n3c_admin.registration on (week = date_trunc('week', n3c_admin.registration.created::date))) as test
					GROUP BY date) as bar
		natural full outer join
			(SELECT 
				date_trunc('week', week::date) AS date,
       			sum(COUNT(dtaexecuted)) OVER (ORDER BY date_trunc('week', week::date)) as dtas
			FROM
				(select week, dtaexecuted from (
					select generate_series(date_trunc('week', min(created::date)), date_trunc('week', now() ), '1 week'::interval) as week 
					from n3c_admin.registration) as foo
					LEFT JOIN n3c_admin.dta_master on (week = date_trunc('week', n3c_admin.dta_master.dtaexecuted::date))) as test
					GROUP BY date) as dta
	order by 1 asc) as json;

</sql:query>

<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

