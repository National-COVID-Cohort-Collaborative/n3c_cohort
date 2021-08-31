<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CCohort">
     select nid,title,regexp_replace(regexp_replace(summary,'[\r\n]+','','g'),'["]','&quot;','g') as description,cross_cutting::boolean from n3c_admin.domain_team order by title;
</sql:query>

{
    "headers": [
        {"value":"title", "label":"Title"},
        {"value":"description", "label":"Description"},
        {"value":"cross_cutting", "label":"Cross Cutting"}
    ],
    "rows" : [
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    {
	    	"nid":"${row.nid}",
	    	"title":"${row.title}",
	        "description":"${row.description}",
	        "cross_cutting":"${row.cross_cutting}"
	    }<c:if test="${!rowCounter.last}">,</c:if>
</c:forEach>
    ]
}
       