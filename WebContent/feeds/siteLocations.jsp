<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:query var="sites" dataSource="jdbc/N3CCohort">
	select map_label as site,ror_id as id,data_in_enclave as released,ctr_ctsa_community as description,org_latitude as latitude,org_longitude as longitude from enclave_cohort.dashboard_map  where data_in_enclave !~'DTA';
</sql:query>

{
  "sites":[
	<c:forEach items="${sites.rows}" var="row" varStatus="rowCounter">
	    {"id":"${row.id}","site":"${row.site}","url":"${row.url}","latitude":"${row.latitude}","longitude":"${row.longitude}", "description":"${row.description}", "status":"${row.released}"}<c:if test="${ rowCounter.count < sites.rowCount }">,</c:if>
	</c:forEach>
  ]
}
