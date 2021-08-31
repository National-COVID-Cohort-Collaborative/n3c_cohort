<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="phenotypes" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
        	FROM (SELECT
        			case when phenotypeid = 1 then ' ' else phenotypename end,
        			phenotypeid,count,phenotypename,referentconceptid,clinicaldescription,literaturereview,
        			phenotypenotes,webapicohortid,cohortname,logicdescription,cohortid,
        			jsonb_pretty(cohortjson::jsonb) as cohortjson
        		  FROM enclave_data.phenotype_final
        		  WHERE logicdescription != 'NA'
                  ORDER BY 1)
         AS foo;
</sql:query>
{
    "phenotypes" :
    <c:forEach items="${phenotypes.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
    </c:forEach>
}