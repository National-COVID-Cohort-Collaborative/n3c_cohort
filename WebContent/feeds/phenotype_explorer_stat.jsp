<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="stats" dataSource="jdbc/N3CCohort">
    <c:choose>
        <c:when test="${param.category == 'covid'}">
            SELECT SUM(CASE WHEN covid_status_name = 'suspected_COVID' THEN count else 0 END)
                 + SUM(CASE WHEN covid_status_name = 'lab_confirmed_positive' THEN count else 0 END) AS total
                 FROM enclave_data.phenotype_overall_covid_status WHERE phenotypeid = ${param.pid}
        </c:when>
        <c:when test="${param.category == 'hospitalized'}">
            SELECT SUM(CASE WHEN severity_type = 'Moderate' THEN count ELSE 0 END)
            + SUM(CASE WHEN severity_type = 'Severe' THEN count ELSE 0 END)
            + SUM(CASE WHEN severity_type = 'Dead_w_COVID' THEN count ELSE 0 END) AS total
             FROM enclave_data.phenotype_overall_severity WHERE phenotypeid = ${param.pid}
        </c:when>
        <c:when test="${param.category == 'death'}">
            SELECT SUM(CASE WHEN severity_type = 'Severe' THEN count ELSE 0 END)
            + SUM(CASE WHEN severity_type = 'Dead_w_COVID' THEN count ELSE 0 END) AS total
             FROM enclave_data.phenotype_overall_severity WHERE phenotypeid = ${param.pid}
        </c:when>
        <c:otherwise>
            SELECT 0 AS total
        </c:otherwise>
    </c:choose>
</sql:query>

 <c:forEach items="${stats.rows}" var="row" varStatus="rowCounter">
     {"${param.category}": ${row.total}}
 </c:forEach>