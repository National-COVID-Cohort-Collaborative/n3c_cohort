<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="graph" uri="http://slis.uiowa.edu/graphtaglib"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<graph:graph>
    <sql:query var="projects" dataSource="jdbc/N3CCohort" >
        select distinct uid,title,research_statement
        from n3c_admin.enclave_project
        where title~'^\[';
    </sql:query>
    <c:forEach items="${projects.rows}" var="row">
    	<c:set var="title" value="${row.title}"/>
    	<c:set var="pitch" value="${row.research_statement}"/>
        <graph:node uri="${row.uid}" label="${row.title}" group="1" score="10" auxString="../images/cd2h_invent.png"/>
    </c:forEach>
		
    <sql:query var="persons" dataSource="jdbc/N3CCohort" >
        select orcid_id,first_name||' '||last_name as name
        from palantir.n3c_user
        where orcid_id in (select distinct orcid_id from n3c_admin.enclave_project_members,n3c_admin.enclave_project where uid=project_uid and title~'^\[');
    </sql:query>
    <c:forEach items="${persons.rows}" var="row">
        <graph:node uri="${row.orcid_id}" label="${row.name}" group="0" score="5" auxString="../images/person_icon.png"/>
    </c:forEach>

    <sql:query var="edges" dataSource="jdbc/N3CCohort">
         select distinct orcid_id,project_uid from n3c_admin.enclave_project_members;
    </sql:query>
    <c:forEach items="${edges.rows}" var="row" varStatus="rowCounter">
        <graph:edge source="${row.project_uid}" target="${row.orcid_id}"  weight="0.1" />
    </c:forEach>

	{
	  "nodes":[
		<graph:foreachNode > 
			<graph:node>
			    {"url":"<graph:nodeUri/>","image_link":"<graph:nodeAuxString/>","name":"<graph:nodeLabel/>","group":<graph:nodeGroup/>,"score":<graph:nodeScore/>}<c:if test="${ ! isLastNode }">,</c:if>
			</graph:node>
		</graph:foreachNode>
		],
	  "links":[
	  	<graph:foreachEdge>
	  		<graph:edge>
			    {"source":<graph:edgeSource/>,"target":<graph:edgeTarget/>,"value":<graph:edgeWeight/>}<c:if test="${ ! isLastEdge }">,</c:if>
	  		</graph:edge>
	  	</graph:foreachEdge>
	  ],
	  "sites":[
		<graph:foreachSiteID>
			{"id":<graph:SiteID/>, "label":"<graph:SiteName/>"}<c:if test="${!isLastID}">,</c:if>
		</graph:foreachSiteID>
		]
	}
	
	
</graph:graph>
