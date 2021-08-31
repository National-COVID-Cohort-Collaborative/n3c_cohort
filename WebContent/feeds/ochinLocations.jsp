<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:query var="sites" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(foo)) from (
		select site,'' as id,'' as url,'OCHIN' as type,'pending' as data_model,'OCHIN site, pending' as status,latitude,longitude from ochin.organization
	) as foo;
</sql:query>

{
  "sites":
	<c:forEach items="${sites.rows}" var="row" varStatus="rowCounter">
		${row.jsonb_pretty}
	</c:forEach>
}
