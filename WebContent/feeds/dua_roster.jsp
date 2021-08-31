<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="dua" dataSource="jdbc/N3CCohort">
    select institutionid, institutionname as name, duaexecuted
    from n3c_admin.dua_master
    where duaexecuted is not null
    order by name;
</sql:query>

{
    "headers": [
        {"value":"site_name", "label":"Institution"},
        {"value":"date_executed", "label":"Date Executed"}
    ],
    "rows" : [
    <c:forEach items="${dua.rows}" var="row" varStatus="rowCounter">
	    {
	    	"site_name":"${row.name}",
	        "date_executed":"${row.duaexecuted}"
	    }<c:if test="${!rowCounter.last}">,</c:if>
</c:forEach>
    ]
}
       