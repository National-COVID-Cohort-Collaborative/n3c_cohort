<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CCohort">
	select count(*) from n3c_pubs.online_cache where ms_id not in (select ms_id from n3c_pubs.match where pmid is not null);
</sql:query>
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	<c:set var="online_count" value="${row.count}" scope="request"/>
</c:forEach>

