<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="meds" dataSource="jdbc/N3CCohort">
    SELECT jsonb_pretty(jsonb_agg(foo order by variable))
    FROM (
    SELECT DISTINCT variable FROM enclave_data.clamped_med_usage_by_severity
    ) AS foo;
</sql:query>
<c:forEach items="${meds.rows}" var="row" varStatus="rowCounter">
    ${row.jsonb_pretty}
</c:forEach>