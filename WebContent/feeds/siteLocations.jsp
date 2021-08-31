<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:query var="sites" dataSource="jdbc/N3CCohort">
	select institutionid as id, institutionname as site, 'x' as url, org_latitude as latitude, org_longitude as longitude, ogo_group_role as description, released from enclave_cohort.site_coordinates order by 1;
</sql:query>

{
  "sites":[
	<c:forEach items="${sites.rows}" var="row" varStatus="rowCounter">
	    {"id":"${row.id}","site":"${row.site}","url":"${row.url}","latitude":"${row.latitude}","longitude":"${row.longitude}", "description":"${row.description}", "status":"${row.released}"}<c:if test="${ rowCounter.count < sites.rowCount }">,</c:if>
	</c:forEach>
  ]
}
