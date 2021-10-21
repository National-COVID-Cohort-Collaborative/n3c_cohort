<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="stats" dataSource="jdbc/N3CCohort">
    <c:choose>
        <c:when test="${param.category == 'covid'}">
            SELECT phenotypeid, SUM(CASE WHEN covid_status_name = 'suspected_COVID' THEN count else 0 END)
                 + SUM(CASE WHEN covid_status_name = 'lab_confirmed_positive' THEN count else 0 END) AS total
                 FROM enclave_data.phenotype_overall_covid_status
                 WHERE phenotypeid IN (1,${param.pid})
                 GROUP BY phenotypeid
        </c:when>
        <c:when test="${param.category == 'outpatients'}">
                    SELECT phenotypeid, SUM(CASE WHEN severity_type = 'Mild' THEN count ELSE 0 END) AS total
                     FROM enclave_data.phenotype_overall_severity WHERE phenotypeid IN (1,${param.pid})
                     GROUP BY phenotypeid
        </c:when>
        <c:when test="${param.category == 'edvisit'}">
                    SELECT phenotypeid, SUM(CASE WHEN severity_type = 'Mild_ED' THEN count ELSE 0 END) AS total
                     FROM enclave_data.phenotype_overall_severity WHERE phenotypeid IN (1,${param.pid})
                     GROUP BY phenotypeid
        </c:when>
        <c:when test="${param.category == 'hospitalized'}">
                    SELECT phenotypeid, SUM(CASE WHEN severity_type = 'Moderate' THEN count ELSE 0 END) AS total
                     FROM enclave_data.phenotype_overall_severity WHERE phenotypeid IN (1,${param.pid})
                     GROUP BY phenotypeid
        </c:when>
        <c:when test="${param.category == 'icu'}">
            SELECT phenotypeid, SUM(CASE WHEN severity_type = 'Severe' THEN count ELSE 0 END) AS total
             FROM enclave_data.phenotype_overall_severity WHERE phenotypeid IN (1,${param.pid})
             GROUP BY phenotypeid
        </c:when>
        <c:when test="${param.category == 'death'}">
            SELECT phenotypeid, SUM(CASE WHEN severity_type = 'Dead_w_COVID' THEN count ELSE 0 END) AS total
             FROM enclave_data.phenotype_overall_severity WHERE phenotypeid IN (1,${param.pid})
             GROUP BY phenotypeid
        </c:when>
        <c:otherwise>
            SELECT phenotypeid, 0 AS ${param.category}
        </c:otherwise>
    </c:choose>
</sql:query>
{
    "${param.category}":
     {
         <c:forEach items="${stats.rows}" var="row" varStatus="rowCounter">
            <c:choose>
                <c:when test="${row.phenotypeid == 1}">"all":</c:when>
                <c:otherwise>"sub":</c:otherwise>
            </c:choose>
            ${row.total}<c:if test="${rowCounter.count < stats.rowCount}">, </c:if>
         </c:forEach>
     }
 }